Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D4814123B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 21:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgAQUWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 15:22:22 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39600 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:22:22 -0500
Received: by mail-pj1-f65.google.com with SMTP id e11so3821357pjt.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 12:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OX20k02zLinNEX8iitXOjsY50EZT0UDBHwhDSEhOIdc=;
        b=abJq9VWNQX8VO5sjbQXPjzJB03GwN21msGGFgVJfMX6G1Lb3YFRfa4RHtEeX9aNVr1
         HaHZzSqBB/E/zCWNOoGOENiYtcz+MWh7EB2ZkgwkYWy6DLdkZ2sPhtbsYZCWzG/CIFTW
         REuQZkmFwXq8TlySWNHDL4o0p8rQDopfjXR4SQsLg49OLpUt4QhzeMjujdkc5EwHZg4j
         fM/4Nhvd2CjXpGUKzZaNb+3L77bhdwNG7NaLLuZP3oo8cT9WNJY2rFnF8dURhiPN+WS1
         g4lyk6iMjchFcGo1MJbGVPUj8gug1dfn6a+JVA87FaLCzziOLMlfBeRumWy371AyXepU
         u6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OX20k02zLinNEX8iitXOjsY50EZT0UDBHwhDSEhOIdc=;
        b=I+8RU+E8yPhvlZHrfWi3xXU3/l0/lr8xy+el0pJHM3Jf7BCafBYXBf+8kg1jSRloIl
         Xs/jd1stnvQDXbAYkgHT6DHMEVg11fBwhItypR1G0hrpFAovshW0xehaJFc6MfTyH3rg
         ynqarqYKZvlLIkVq7O0vLYvmp5eNYRNSipAAR6OBq+hZGxLCdAgwI86Cm9e1zSkQJ3Cb
         XwAr54NlpYQeL7QSiWxIUbUhs0E6DZa3J0ZITKxuIhi4rcbTXptinDIYKMoAQfSp63C1
         mo6/4BXpEHwYnQ9cEjPbVxXzimXlPIbJN9gYwPjlKNVGc3/oIxm03qPqIsWWop6EWvDU
         pAfw==
X-Gm-Message-State: APjAAAXA2qOdfHAyF3hLMnJ9+O0a5faPU8otIhuF5g1+/E07sdRRNFfN
        fkBmaAarzwjAIEi0E7iMEI09qg==
X-Google-Smtp-Source: APXvYqz331WlYKGiYYHKsxCQgWwRHhFlPXl+v7EQEieIdVln+QMnfBO3IotAqa3q13J4sf/cnEDdfA==
X-Received: by 2002:a17:902:b781:: with SMTP id e1mr1042626pls.128.1579292541212;
        Fri, 17 Jan 2020 12:22:21 -0800 (PST)
Received: from vader ([2620:10d:c090:200::c6e6])
        by smtp.gmail.com with ESMTPSA id l10sm8429735pjy.5.2020.01.17.12.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 12:22:20 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:22:19 -0800
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
Message-ID: <20200117202219.GB295250@vader>
References: <364531.1579265357@warthog.procyon.org.uk>
 <d2730b78cf0eac685c3719909df34d8d1b0bc347.camel@hammerspace.com>
 <20200117154657.GK8904@ZenIV.linux.org.uk>
 <20200117163616.GA282555@vader>
 <20200117165904.GN8904@ZenIV.linux.org.uk>
 <20200117172855.GA295250@vader>
 <20200117181730.GO8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117181730.GO8904@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 06:17:30PM +0000, Al Viro wrote:
> On Fri, Jan 17, 2020 at 09:28:55AM -0800, Omar Sandoval wrote:
> > On Fri, Jan 17, 2020 at 04:59:04PM +0000, Al Viro wrote:
> > > On Fri, Jan 17, 2020 at 08:36:16AM -0800, Omar Sandoval wrote:
> > > 
> > > > The semantics I implemented in my series were basically "linkat with
> > > > AT_REPLACE replaces the target iff rename would replace the target".
> > > > Therefore, symlinks are replaced, not followed, and mountpoints get
> > > > EXDEV. In my opinion that's both sane and unsurprising.
> > > 
> > > Umm...  EXDEV in rename() comes when _parents_ are on different mounts.
> > > rename() over a mountpoint is EBUSY if it has mounts in caller's
> > > namespace, but it succeeds (and detaches all mounts on the victim
> > > in any namespaces) otherwise.
> > > 
> > > When are you returning EXDEV?
> > 
> > EXDEV was a thinko, the patch does what rename does:
> > 
> > 
> > +	if (is_local_mountpoint(new_dentry)) {
> > +		error = -EBUSY;
> > +		goto out;
> > +	}
> > 
> > ...
> > 
> > +	if (target) {
> > +		dont_mount(new_dentry);
> > +		detach_mounts(new_dentry);
> > +	}
> > 
> > Anyways, my point is that the rename semantics cover 90% of AT_REPLACE.
> > Before I resend the patches, I'll write up the documentation and we can
> > see what other corner cases I missed.
> 
> OK... rename() has a major difference from linkat(), though, in not
> following links (or allowing fd + empty path).  link() is deeply
> asymmetric in treatment of pathnames - the first argument is
> "pathname describes a filesystem object" and the second - "pathname
> descripes an entry in a directory" (the link to be).  rename() is
> not - both arguments are pathnames-as-link-specifiers.  And that
> affects what is and what is not allowed there, so that'll need
> a careful look into.
> 
> FWIW, currently linkat() semantics can be described simply enough
> 	* oldfd/oldname specifies an fs object; symlink traversal is
> optional.
> 	* newfd/newname specifies an entry in some directory.  Directory
> must be on the same mount as the object specified by oldname.
> Entry must be a normal component (no empty paths allowed, no . or ..
> either).  Trailing slashes are not allowed.  There must be no
> entry with that name (which automatically implies that trailing
> symlinks are not to be followed and there can't be anything
> mounted on it).
> 	* the object specified by oldname must be a non-directory.
> 	* if the object is not a never-linked-yet anonymous,
> it must still have some links.
> 	* caller must have permission to create links in the
> affected directory.
> 	* append-only and immutables are not allowed (rationale:
> they can't be unlinked)
> 	* filesystem is allowed to fail for any reasons, as with
> any operation; a linkat()-specific one is having the link count
> overflow, but any generic error is possible (out of memory, IO
> error, EPERM-because-I-feel-like-that, etc.)
> 
> All checks related to object in question are atomic wrt operations
> that add or remove links to that object.  Checks on parent are
> atomic wrt operations modifying the parent.  Neither group is
> atomic wrt operations modifying the _old_ parent (if there's
> any, in the first place).

Since manpage troff patches aren't particularly nice to read, here is
what I had in mind in a readable form:

int linkat(int olddirfd, const char *oldpath, int newdirfd,
	   const char *newpath, int flags);

	AT_REPLACE
		If newpath exists, replace it atomically. There is no
		point at which another process attempting to access
		newpath will find it missing.
	
		newpath must not be a directory.
	
		If oldpath and newpath are existing hard links referring
		to the same file, then this does nothing, and returns a
		success status. If newpath is a mount point, then this
		comparison considers the mount point, not the mounted
		file or directory.
	
		If newpath refers to a symbolic link, the link will be
		overwritten.

ERRORS
	EBUSY	AT_REPLACE was specified in flags, newpath is a mount
		point, and the mount point does not refer to the same
		file as oldpath. Or, AT_REPLACE was specified in flags
		and newpath ends with a . or .. component.

	EISDIR	AT_REPLACE was specified in flags and newpath is an
		existing directory.
---

Overall, I think what makes the most sense is that AT_REPLACE does not
change the treatment of oldpath and is as consistent with rename(2) for
the treatment of newpath. Therefore, linkat with AT_RENAME:

* Doesn't traverse mounts on newpath (see below).
* If newpath is a symlink, doesn't follow it.
* Returns EBUSY for trailing . and .. components instead of EEXIST like
  you get without AT_REPLACE.
* Is a noop if linking a file to a hard link of itself.

The hairiest bit is that last point if there are mounts involved. As I
mentioned, we probably want to handle oldpath exactly the same whether
or not AT_REPLACE is used, so we will always traverse mounts and follow
symlinks (modulo AT_SYMLINK_FOLLOW). However, let's consider how rename
handles mounts on newpath:

# cat rename.c
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
        if (argc != 3) {
                fprintf(stderr, "%s: SOURCE DEST\n", argv[0]);
                return EXIT_FAILURE;
        }
        if (rename(argv[1], argv[2]) == -1) {
                perror("rename");
                return EXIT_FAILURE;
        }
        return EXIT_SUCCESS;
}
# touch a b
# ln b c
# mount --bind a c
# ./rename b c

This succeeds because rename treats the path as an entry in a directory.
It doesn't traverse the mount on "c", so "c" is still considered the
same file as "b".

# umount c
# mount --bind c a
# ./rename b a
rename: Device or resource busy

Likewise, this fails because the underlying "a" mount point is not the
same file as "b".

So the rules for "same file" are "oldpath follows mounts and symlinks as
appropriate" and "newpath does not follow mounts or symlinks". The
asymmetry is a bit awkward, but I think it's the soundest choice.

Thoughts? Any other gaps here?

Thanks!
