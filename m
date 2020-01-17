Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7FD1414F9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 00:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgAQXyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 18:54:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34871 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbgAQXyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:54:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so12409321pgk.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QbARbaVL74vy2DItD1te3MjnvjTqI/vyVTF5YAOSKv8=;
        b=CLKphqXHSAotO8RxSjxR6F4YWeQHScI9pbW4AZYRd0U+hsFfgt3PtP5GEF5dq8Ku1M
         putBJ0YN7PI7rscZNXID6c0dCKQnTV3sP3BNc9oiiMwrKCnCEEMFfHND+UADGuFczBMR
         ETMpBddXH0rJbRgbrCrnW/pt4T/+CqKzxSjZktsEyJOOONjqfCW8wlVHFDIsTk12aZeH
         wC1hBVeDOpI4lNNFWGu2csBmj+WnGMK2S027sJAaOL5SBmiKVe57C6qbziL91LCXa/sc
         g3OUUp/C5Tf6uvEtJA30kjjMex+15hsMI6+7EdruPhzomuPkU+ySZE9aXtlMA1fR5sPU
         Wf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QbARbaVL74vy2DItD1te3MjnvjTqI/vyVTF5YAOSKv8=;
        b=cJv9v2mq+HQ2rKF1LoLAX+TNq6oliJwilr8VX3sc7PcepkGCJUI8FCT8YX/C/81njg
         fOmTAJlEH1LOCc9bTTepR+xiVmwSIhoj4/wuLv5By/w8ebrKc99mzG3vnF0WfsJGLlJN
         hgDTHI7ZWB7CWf21G78BBlHrzBZDwbi0mWqZgBEzi9uEcTYs/eYUdemAWQzgQdW8f+vq
         iwkKhO5+BLN4YJdf1EUcJQFMM0BEg82ZV/CJ69K9g32Z34ustmRzhjzesIZKcx4V2/kG
         r0MYBZOmgZ+6+LO4KLugb8IlMiTP5Sj8iieb4+/fA3fC60CJg177ZZVRNjisyVNc7kOf
         XG4Q==
X-Gm-Message-State: APjAAAWTTi1jZqZEbzLlkGpbmSsS+uKbPyJfXC4P019+Os1lU66uqMKI
        M7TfiwAfNO5/lQbXPB7wTKwVbv5io0U=
X-Google-Smtp-Source: APXvYqzy3iYdcG1MDTg8M1OFw7M2pX3B4uLQpPYe1MFNIxJGYhpU55T1LDF5sc0UJXCn2xvm9fzGQQ==
X-Received: by 2002:aa7:820d:: with SMTP id k13mr5761463pfi.10.1579305285590;
        Fri, 17 Jan 2020 15:54:45 -0800 (PST)
Received: from vader ([2620:10d:c090:200::c6e6])
        by smtp.gmail.com with ESMTPSA id o16sm29407945pgl.58.2020.01.17.15.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 15:54:45 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:54:44 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Allowing linkat() to replace the destination
Message-ID: <20200117235444.GC295250@vader>
References: <364531.1579265357@warthog.procyon.org.uk>
 <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <20200117154657.GK8904@ZenIV.linux.org.uk>
 <20200117163616.GA282555@vader>
 <20200117165904.GN8904@ZenIV.linux.org.uk>
 <20200117172855.GA295250@vader>
 <20200117181730.GO8904@ZenIV.linux.org.uk>
 <20200117202219.GB295250@vader>
 <20200117222212.GP8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117222212.GP8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 10:22:12PM +0000, Al Viro wrote:
> On Fri, Jan 17, 2020 at 12:22:19PM -0800, Omar Sandoval wrote:
> 
> > Since manpage troff patches aren't particularly nice to read, here is
> > what I had in mind in a readable form:
> > 
> > int linkat(int olddirfd, const char *oldpath, int newdirfd,
> > 	   const char *newpath, int flags);
> > 
> > 	AT_REPLACE
> > 		If newpath exists, replace it atomically. There is no
> > 		point at which another process attempting to access
> > 		newpath will find it missing.
> > 	
> > 		newpath must not be a directory.
> > 	
> > 		If oldpath and newpath are existing hard links referring
> > 		to the same file, then this does nothing, and returns a
> > 		success status. If newpath is a mount point, then this
> > 		comparison considers the mount point, not the mounted
> > 		file or directory.
> > 	
> > 		If newpath refers to a symbolic link, the link will be
> > 		overwritten.
> > 
> > ERRORS
> > 	EBUSY	AT_REPLACE was specified in flags, newpath is a mount
> > 		point, and the mount point does not refer to the same
> > 		file as oldpath. Or, AT_REPLACE was specified in flags
> > 		and newpath ends with a . or .. component.
> 
> > 	EISDIR	AT_REPLACE was specified in flags and newpath is an
> > 		existing directory.

Thanks for taking a look.

> So are <existing directory>/. or <existing directory>/.., so I wonder why
> bother with -EBUSY there.

This was for consistency with rename, as it happens to check for . and
.. before it checks whether oldpath is a directory. I don't feel
strongly either way.

> As for the gaps...
> 	1) emptypath for new.  Should be an error; EINVAL, probably.
> Avoids arseloads of fun cases ("what if newfd/newpath refers to something
> unlinked?", etc., etc.)

linkat(2) explicitly mentions that AT_EMPTY_PATH only applies to
oldpath, so this falls back to the standard ENOENT documented in
path_resolution(7).

> 	2) mountpoint vs. mountpoint in the local namespace.  See the
> rationale in that area for unlink()/rmdir()/rename().

I'll add that.

Side-note, unlink(2), rmdir(2), and rename(2) should probably mention
this behavior, too...

> 	3) permission checks need to be specified

I believe the only difference here vs standard linkat is that newpath
must not be immutable or append-only?

> 	4) as for the hardlinks, I would be very careful with the language;
> if anything, that's probably "if the link specified by newfd/newpath points
> to the object specified by oldfd/oldpath..."

It seems like there's room for elaborating on the distinction between
path-to-a-file vs. path-to-a-dir-entry in path_resolution(7). In the
meantime, I'll mention it explicitly.

> Another thing is, as you
> could've seen for rename(), such "permissive" clauses tend to give surprising
> results.  For example, put the check for "it's a hardlink" early enough,
> and you've suddenly gotten a situation when it *can* succeed for directory.
> Or on a filesystem that never allowed hardlinks (the latter is probably
> unavoidable).

Good point. Unless I'm missing something, the only way you'll end up
with two paths referring to the same directory/file on a filesystem not
supporting hardlinks is through multiple mounts of the same filesystem,
and I check for the EXDEV case earlier than the same file case. I'll
double-check for other cases.

> 	5) what _really_ needs to be said is that other links to
> newpath are unaffected and so are previously opened files.

Done.

> 	6) "atomically" is bloody vague; the explanation you've put there
> is not enough, IMO - in addition to "nobody sees it gone in the middle
> of operation" there's also "if the operation fails, the target remains
> undisturbed" and something along the lines of "if filesystem makes any
> promises about the state after dirty shutdown in the middle of rename(),
> the same promises should apply here".

Done. I'd be nice if I could say "refer to rename(2) for durability
guarantees", but rename(2) doesn't mention it at all.

> references to pathconf, Cthulhu and other equally delightful entities
> are not really welcome.

EOPNOTSUPP is probably the most helpful.

> There might be be more - like I said, it needs to go through
> linux-abi, fsdevel and security lists.  The above is all I see right
> now, but I might be missing something subtle (or not so subtle).

Here's the updated description. If you don't see any other glaring
problems, I'll update the implementation and send it out to the
appropriate lists.

int linkat(int olddirfd, const char *oldpath, int newdirfd,
	   const char *newpath, int flags);

	AT_REPLACE
		If newpath exists, replace it atomically. There is no
		point at which another process attempting to access
		newpath will find it missing. If newpath exists but the
		operation fails, the original link specified by newpath
		will remain in place. This has the same durability
		guarantees for newpath as rename(2).

		If newpath is replaced, any other hard links referring
		to the file are unaffected. Open file descriptors for
		newpath are also unaffected.
	
		newpath must not be a directory.
	
		If the entry specified by newpath refers to the file
		specified by oldpath, linkat() does nothing and returns
		a success status. Note that this comparison does not
		follow mounts on newpath.

		Otherwise, newpath must not be a mount point in the
		local namespace. If it is a mount point in another
		namespace and the operation succeeds, all mounts are
		detached from newpath in all namespaces, as is the case
		for rename(2), rmdir(2), and unlink(2).
	
		If newpath refers to a symbolic link, the link will be
		overwritten.

ERRORS
	EBUSY	AT_REPLACE was specified in flags, newpath is a mount
		point in the local namespace, and the mount point does
		not refer to the same file as oldpath. Or, AT_REPLACE
		was specified in flags and newpath ends with a . or ..
		component.

	EISDIR	AT_REPLACE was specified in flags and newpath is an
		existing directory.

	EOPNOTSUPP
		AT_REPLACE was specified in flags and the filesystem
		containing newpath does not support AT_REPLACE.

	EPERM	AT_REPLACE was specified and newpath refers to an
		immutable or append-only file.

> As for the implementation... VFS side should be reasonably easy (OK,
> it'll bloat do_symlinkat() quite a bit, since we won't be able to use
> filename_create() for the target in there, but it's not _that_
> terrible).

Based on my previous attempt at it [1], it's not too bad.

> I'd probably prefer a separate method rather than
> overloading ->link(), with the old method called when the target
> is negative and new - when it's positive - less boilerplate and
> harder for an instance to get confused.  They can easily use common
> helpers with ->link() instances, so the code duplication won't
> be an issue.

Agreed, thanks again!

1: https://lore.kernel.org/linux-fsdevel/eac9480f80c689504148b5d658ee4218cc1e421e.1524549513.git.osandov@fb.com/
