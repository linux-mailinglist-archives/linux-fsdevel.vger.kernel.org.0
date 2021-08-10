Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880B43E849D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhHJUvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhHJUvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:51:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40379C0613D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 13:51:14 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id s132so3158727qke.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 13:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ho1c4ybrIcKzeGnDZgrxScKRAzWLoVC8JJLL8evuc10=;
        b=f9qqvba+vb4gKwoCe07TXYMmUbaDXkZASg1FIRrHiPUcT5xNflmTPouhEjP+OKukFA
         JrBHXe6q0qqN+p8I85JakAdvaW7qkmCwVulGcmwvtS8XfvfUstRLmzily7+p2qiRG/Rd
         ce8sAGw3nurfeSFUfO2zWYO6Vk7Y97fPeE0gqluQpETHMGhK4jaqHA3o5QzzNdc3Os1o
         yqD2euebrIm5Dk2N3HvSbv4TfMqsN/UAXw++5xQJfVaDk0DLxs/e38xHd8ZgaCS5CJue
         KmtS67AmwsMADk5+iBxDaxLwsnAZmF1xU0eOzZ3o3pwNRIfnp2NmSALJYoawiypqyaiR
         UcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ho1c4ybrIcKzeGnDZgrxScKRAzWLoVC8JJLL8evuc10=;
        b=pG2caCyyWnvQCeDUjBMnZ/VFU1uoVw2/BndrzWBt+IBvx5fo7QNJTp9d+4oyGH6pol
         TX3ujyL9txDId/0FizssetvnYPm4jIQ2dJzuxstXodPROIEiaIybjo1DlaW+6DWWd+Uh
         Kn+A8EFDN8PU/WXDabAlov5tz5f7PNMyf90K32dlE4EXzz1EOxjPFf2hjLi9xZSYhuHe
         Wf5C76NUiK+EIsTDmgrzE9BvjgEp+O5syHDXoPhJDm6hpBxWB+Z+TAeRpgB22VVhWxKH
         s5IUZsa59L9ofYkxVVDG91G0qa5zbVTHL44nT0RWRlRIvoykc0GQIn7ZwaLoXh4xs6eL
         4V5w==
X-Gm-Message-State: AOAM5310ekxJwEeQ7ZLDPFsWB1YQBSPgGBeUOK59RFuUgX0tQsu1tUsJ
        0+We3r4m2nMberL/RbgCwRQoTg==
X-Google-Smtp-Source: ABdhPJx3pKon7AS8dHaL6WVED3noFCHCxvgT4RFGk6L33KlHcBR2uE+f1VmyEqQG0ckWgQJUo/o91Q==
X-Received: by 2002:ae9:e213:: with SMTP id c19mr30144120qkc.451.1628628673318;
        Tue, 10 Aug 2021 13:51:13 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10ba? ([2620:10d:c091:480::1:6dda])
        by smtp.gmail.com with ESMTPSA id v9sm7871780qtq.77.2021.08.10.13.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 13:51:12 -0700 (PDT)
Subject: Re: [PATCH/RFC 0/4] Attempt to make progress with btrfs dev number
 strangeness.
To:     NeilBrown <neilb@suse.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <162848123483.25823.15844774651164477866.stgit@noble.brown>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e6496956-0df3-6232-eecb-5209b28ca790@toxicpanda.com>
Date:   Tue, 10 Aug 2021 16:51:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162848123483.25823.15844774651164477866.stgit@noble.brown>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/8/21 11:55 PM, NeilBrown wrote:
> I continue to search for a way forward for btrfs so that its behaviour
> with respect to device numbers and subvols is somewhat coherent.
> 
> This series implements some of the ideas in my "A Third perspective"[1],
> though with changes is various details.
> 
> I introduce two new mount options, which default to
> no-change-in-behaviour.
> 
>   -o inumbits=  causes inode numbers to be more unique across a whole btrfs
>                 filesystem, and is many cases completely unique.  Mounting
>                 with "-i inumbits=56" will resolve the NFS issues that
>                 started me tilting at this particular windmill.
> 
>   -o numdevs=  can reduce the number of distinct devices reported by
>                stat(), either to 2 or to 1.
>                Both ease problems for sites that exhaust their supply of
>                device numbers.
>                '2' allows "du -x" to continue to work, but is otherwise
>                rather strange.
>                '1' breaks the use of "du -x" and similar to examine a
>                single subvol which might have subvol descendants, but
>                provides generally sane behaviour
>                "-o numdevs=1" also forces inumbits to have a useful value.
> 
> I introduce a "tree id" which can be discovered using statx().  Two
> files with the same dev and ino might still be different if the tree-ids
> are different.  Connected files with the same tree-id may be usefully
> considered to be related.
> 
> I also change various /proc files (only when numdevs=1 is used) to
> provide extra information so they are useful with btrfs despite subvols.
> /proc/maps /proc/smaps /proc/locks /proc/X/fdinfo/Y are affected.
> The inode number becomes "XX:YY" where XX is the subvol number (tree id)
> and YY is the inode number.
> 
> An alternate might be to report a number which might use up to 128 bits.
> Which is less likely to seriously break code?
> 
> Note that code which ignores badly formatted lines is safe, because it
> will never currently find a match for a btrfs file in these files
> anyway.  The device number they report is never returned in st_dev for
> stat() on any file.
> 
> The audit subsystem and one or two other places report dev/ino and so
> need enhanced, but I haven't tried to address those.
> 
> Various trace points also report dev/ino.  I haven't tried thinking
> about those either.

I think this is a step in the right direction, but I want to figure out a way to 
accomplish this without magical mount points that users must be aware of.

I think the stat() st_dev ship as sailed, we're stuck with that.  However 
Christoph does have a valid point where it breaks the various info spit out by 
/proc.  You've done a good job with the treeid here, but it still makes it 
impossible for somebody to map the st_dev back to the correct mount.

I think we aren't going to solve that problem, at least not with stat().  I 
think with statx() spitting out treeid we have given userspace a way to 
differentiate subvolumes, and so we should fix statx() to spit out the the super 
block device, that way new userspace things can do their appropriate lookup if 
they so choose.

This leaves the problem of nfsd.  Can you just integrate this new treeid into 
nfsd, and use that to either change the ino within nfsd itself, or do something 
similar to what your first patchset did and generate a fsid based on the treeid?

Mount options are messy, and are just going to lead to distro's turning them on 
without understanding what's going on and then we have to support them forever. 
  I want to get this fixed in a way that we all hate the least with as little 
opportunity for confused users to make bad decisions.  Thanks,

Josef

