Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E916410803
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbhIRSHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 14:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbhIRSGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 14:06:48 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60875C061757
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Sep 2021 11:05:24 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m21so3823305pgu.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Sep 2021 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHF5eltD4tQILoEVHPkgJ2QhWZ++2yVqpqRJwk/b+9k=;
        b=iS+caskSRBzXps0YEr/TohhGh8bKQ0XN9L+Ux2WXo3XV2AuLSQRxfDDR8pVuzKIQD1
         r2i1IBNgvWOROuHFnJdN5vndakEflPpudUHWUbdDCjwViqo+fS6gCamb3GLsEFAu9RAS
         99879FL3AupNRa1n5G5ag5ToKY9sRm78X01oiQ+qNCO+nx9kY0V/COeBJVrc3uiQaJ/u
         PaZVxeWcI/OsjL4sZlYtOxcSEvbojdzCCaIB4liVyq0jkarO09WO/tXOz6Ob+gCeYvSJ
         S92VcctTfq1hiQIhX1bB573UPZHxaufdY6gCKIhfCHeSS4wD5OhtUBt7jFv4d65IgOn4
         VepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHF5eltD4tQILoEVHPkgJ2QhWZ++2yVqpqRJwk/b+9k=;
        b=MRs5xQhJla+YS2p2kk8MAf++o5t7B42iDGs4y/9UsLmJBXRJoqNaGV+3M//DOqnQC7
         9TxGzTtOHF+hmxGbHO8V6wmRxLo+irXjSdsM4CJqA+o7UPQo6jAvJpYQzLYaYPnJ7lXt
         M+jgGEvQYnQlQ6AYaLSu1pn40Qw+VGWHoDL0KSnZthNIAn86DLMArJniRKqBklxjPqOM
         G5MeBz8I6eddRaSsRSvaChHk5hKnwguUiizzPA2b/yAO/jbS3KI6tEvU1vLl2weix57+
         F0aMbJZdTm9pwFQ/8a581nuUHbbyy20XAsI0O1geAxGCa8zTBZDn4bbP539bjfx5WH20
         AIjw==
X-Gm-Message-State: AOAM532FbyE77cnX61mFdtgopS6ZpwKB6kqSg+E1qoJqbMD33rWob08R
        u11Q1ZmiLUtnoxpy7qrp4LPZZ8lmBYte69NpBVVh7A==
X-Google-Smtp-Source: ABdhPJx96o7LNikSIXLNv0gGStkfn5Ktyuk2DPBHf86tKPID3seDPfgzA4BEbUxEoy1pFR4RCe33aR3WpBgjvQzqAdE=
X-Received: by 2002:a62:7f87:0:b0:444:b077:51ef with SMTP id
 a129-20020a627f87000000b00444b07751efmr6651952pfd.61.1631988323836; Sat, 18
 Sep 2021 11:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <163192864476.417973.143014658064006895.stgit@magnolia>
In-Reply-To: <163192864476.417973.143014658064006895.stgit@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 18 Sep 2021 11:05:13 -0700
Message-ID: <CAPcyv4i8qcDSFvRSMJTKQhedgbJ5c_cMKH3+FSX_veoLNVSvqQ@mail.gmail.com>
Subject: Re: [PATCHSET RFC v2 jane 0/5] vfs: enable userspace to reset damaged
 file storage
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jane Chu <jane.chu@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 6:30 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Hi all,
>
> Jane Chu has taken an interest in trying to fix the pmem poison recovery
> story on Linux.  Since I sort of had a half-baked patchset that seems to
> contain some elements of what the reviewers of her patchset wanted, I'm
> releasing this reworked version to see if it has any traction.
>
> Our current "advice" to people using persistent memory and FSDAX who
> wish to recover upon receipt of a media error (aka 'hwpoison') event
> from ACPI is to punch-hole that part of the file and then pwrite it,
> which will magically cause the pmem to be reinitialized and the poison
> to be cleared.
>
> Punching doesn't make any sense at all -- the (re)allocation on pwrite
> does not permit the caller to specify where to find blocks, which means
> that we might not get the same pmem back.

Not sure this is a driving concern. If you get the same pmem back it
will have gone through a poison clearing cycle when it gets
reallocated. Also, once the filesystem gets notified of error
locations through Ruan's series the FS can avoid allocating blocks
where poison clearing failed.

> This pushes the user farther
> away from the goal of reinitializing poisoned memory and leads to
> complaints about unnecessary file fragmentation.

Fragmentation though is a valid concern.

>
> AFAICT, the only reason why the "punch and write" dance works at all is
> that the XFS and ext4 currently call blkdev_issue_zeroout when
> allocating pmem ahead of a write call.  Even a regular overwrite won't
> clear the poison, because dax_direct_access is smart enough to bail out
> on poisoned pmem, but not smart enough to clear it.

Alignment constraints were the entanglement that kept DAX from poison
clearing. This is similar to the dance you need to do to get a disk to
remap a bad block, which needs an O_DIRECT write. It was also deemed
messy to keep overloading writes this way.

> To be fair, that
> function maps pages and has no idea what kinds of reads and writes the
> caller might want to perform.
>
> Therefore, clean up this whole mess by creating a dax_zeroinit_range
> function that callers can use on poisoned persistent memory to reset the
> contents of the persistent memory to a known state (all zeroes) and
> clear any lingering poison state that might be lingering in the memory
> controllers.  Create a new fallocate mode to trigger this functionality,
> then wire up XFS and ext4 to use it.  For good measure, wire it up to
> traditional storage if the storage has a fast way to zero LBA contents,
> since we assume that those LBAs won't hit old media errors.

Sounds good, I'll take a look at the rest.
