Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C2756631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 12:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFZKFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 06:05:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46944 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfFZKFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:05:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so1965466wrw.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2019 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f7ACw4s8Mi4a2I/fdnBCYeuXebFGdeAxi4+Z9ntqXKU=;
        b=J50QEP5UEr27ielAxFpEtuvfvK1Vu/ClVrLBhLAcga/zuTzZqGQBW/lru19zIMQbZQ
         pE5jXJR2gURgWuen2AK2d7D+S8W6z8h/D6Pr7ZQs+C1CksE0/4N9EufI6zg5YX3MMql0
         pTZ1r7IyYgf9BZIysRZJmSrGFEqHdp8zxOZtTqdXtIwKiiJCFneAlHh5AnAsaqo/c+6V
         TIjHoVrroMXY2chzB+JWmmweQV4WlBiwSssoR2RgMvzqnj4MLnckWg++VOSylD1KPpmR
         6mOUp6W4vi2wNihfYbOb7KqNrtsioZyegDDSQ9ZltbgnGA1GUIqEpaRb3FuLoWtL2Oe6
         baCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7ACw4s8Mi4a2I/fdnBCYeuXebFGdeAxi4+Z9ntqXKU=;
        b=pYUClyoJc0QXtUs6QpFSMTm/6ikrso8flYPnOSNxxxl67OgqiJGN3ID+YUdNmuZQXs
         MHYQBPn8MeTm/mn63TCaEhM8aRhw546bQEVUDu7N+AQQr2DRx0PAtOeapPQkKIQwboH3
         DuQw5T9uJxFbfWxTHUOuFi0ZLYtp2SCHkr5rVUvOXALopm6H1h8eK7mBvH+pYqCrhB4e
         fIQWizMDtkT2Fj2td1Po2PVqSbSTrlOXe2igBkjSqAauD4iPRwBviLGhhhJp0YO7HygT
         cE0Ew1W/fDmrOSx3kHzWcQ5mbedqPq1j/4iETJckB+bqhCtm8Al6//PtYluDUUjKkVHr
         8qkQ==
X-Gm-Message-State: APjAAAWGkqZjvr3mpPmmte3YyyDXINoFRtcNEnlb89+xDQE2OkIRvJQZ
        q7XzUaNm2W5wAAm0OczPYKlngw==
X-Google-Smtp-Source: APXvYqwoMHNUNhEqCtJRpuGWh9bxOFjXSjkKAbBuEsHBvkXRMh5MMHAAUAMOHlxbY3gZk3AZc52HjQ==
X-Received: by 2002:a5d:51c6:: with SMTP id n6mr2466653wrv.296.1561543528299;
        Wed, 26 Jun 2019 03:05:28 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id s8sm21271216wra.55.2019.06.26.03.05.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:05:27 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:05:26 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] VFS: Introduce filesystem information query
 syscall [ver #14]
Message-ID: <20190626100525.irdehd24jowz5f75@brauner.io>
References: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 03:08:45PM +0100, David Howells wrote:
> 
> Hi Al,
> 
> Here are a set of patches that adds a syscall, fsinfo(), that allows
> attributes of a filesystem/superblock to be queried.  Attribute values are
> of four basic types:
> 
>  (1) Version dependent-length structure (size defined by type).
> 
>  (2) Variable-length string (up to PAGE_SIZE).
> 
>  (3) Array of fixed-length structures (up to INT_MAX size).
> 
>  (4) Opaque blob (up to INT_MAX size).
> 
> Attributes can have multiple values in up to two dimensions and all the
> values of a particular attribute must have the same type.
> 
> Note that the attribute values *are* allowed to vary between dentries
> within a single superblock, depending on the specific dentry that you're
> looking at.
> 
> I've tried to make the interface as light as possible, so integer/enum
> attribute selector rather than string and the core does all the allocation
> and extensibility support work rather than leaving that to the filesystems.
> That means that for the first two attribute types, sb->s_op->fsinfo() may
> assume that the provided buffer is always present and always big enough.
> 
> Further, this removes the possibility of the filesystem gaining access to the
> userspace buffer.
> 
> 
> fsinfo() allows a variety of information to be retrieved about a filesystem
> and the mount topology:
> 
>  (1) General superblock attributes:
> 
>       - The amount of space/free space in a filesystem (as statfs()).
>       - Filesystem identifiers (UUID, volume label, device numbers, ...)
>       - The limits on a filesystem's capabilities
>       - Information on supported statx fields and attributes and IOC flags.
>       - A variety single-bit flags indicating supported capabilities.
>       - Timestamp resolution and range.
>       - Sources (as per mount(2), but fsconfig() allows multiple sources).
>       - In-filesystem filename format information.
>       - Filesystem parameters ("mount -o xxx"-type things).
>       - LSM parameters (again "mount -o xxx"-type things).
> 
>  (2) Filesystem-specific superblock attributes:
> 
>       - Server names and addresses.
>       - Cell name.
> 
>  (3) Filesystem configuration metadata attributes:
> 
>       - Filesystem parameter type descriptions.
>       - Name -> parameter mappings.
>       - Simple enumeration name -> value mappings.
> 
>  (4) Mount topology:
> 
>       - General information about a mount object.
>       - Mount device name(s).
>       - Children of a mount object and their relative paths.
> 
>  (5) Information about what the fsinfo() syscall itself supports, including
>      the number of attibutes supported and the number of capability bits
>      supported.

Phew, this patchset is a lot. It's good of course but can we please cut
some of the more advanced features such as querying by mount id,
submounts etc. pp. for now?
I feel this would help with review and since your interface is
extensible it's really not a big deal if we defer fancy features to
later cycles after people had more time to review and the interface has
seen some exposure.

The mount api changes over the last months have honestly been so huge
that any chance to make the changes smaller and easier to digest we
should take. (I'm really not complaining. Good that the work is done and
it's entirely ok that it's a lot of code.)

It would also be great if after you have dropped some stuff from this
patchset and gotten an Ack we could stuff it into linux-next for some
time because it hasn't been so far...

Christian
