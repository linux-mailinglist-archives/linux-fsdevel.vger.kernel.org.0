Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF53368ACA0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 22:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjBDVjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 16:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBDVjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 16:39:14 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864D27992;
        Sat,  4 Feb 2023 13:39:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so8328109wmb.2;
        Sat, 04 Feb 2023 13:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fIKWmSceHmw8uSx8gjj44vcTkVFyyDB6swe4nbPGfJs=;
        b=acW/7A77GhgMzuYRoMhJw5f5FqBeauOPmztOqttecXvh3Ygf4Pv0+51voNziO858ET
         OMmnOfEnfM5eoCuNn4dBi0YC/7CfwrpLw6owauVJAtw4scQgiUbNHhuqrAcHsbb+ya/3
         3/qvZ3YygjFdwMwDKYYqDp0jVSUeY5DRlzXYxXJV3LqiAvygDQtg94tdRxNINR8uVH3H
         FpowW1h1eSL2CR+9qQihWZxukosq0OyfkuPk3oqiHPBYYTgvqFDLSNbmJMI67Iufhmjb
         j841GNHeUS9+LOUbm+5zmohoKU1X6LfDi9Lp1L24LIytqGsbctxB/5KBzXWrS9Hef4+Y
         2+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIKWmSceHmw8uSx8gjj44vcTkVFyyDB6swe4nbPGfJs=;
        b=Z8FHGjn+j1g4oqADNK9sLiCBnKvC8VTHssS2t2YS5iIS6kLkr8DZ2pAOGwsNBDHgjo
         8S+jo6I8hGel3gOwJl7mVJowMAFyeKlg5rAtgtcTlBSC9P2tx8oOgC0yp3qQJyIV3YjE
         O21WvZn5p0WWdsAdfRTeHQUyNCQ+9PQKfg2mmXMNck91M/XVg94ung1m46vvv9n9APXW
         wD7n8zbUFmI9V6mI6Ht3eFQjEDCgivDsjy3pEzTh35x6IpbLK1fRtwJRedWtk115NBbS
         7vBVZC4sv17IRed/tzNyq5q+UDjoSRIPVhw6UNHaSkwE8GBfmY+edjrITXQJKiysXubG
         RZhQ==
X-Gm-Message-State: AO0yUKXClrj9lKiW5g80nq5gEZa+Drp4ExVJb+aX4MezD57lpAjvcGKS
        21hlXHSfVdIzUahhm/FTOqfM1pc+JqYmBCeWwq8=
X-Google-Smtp-Source: AK7set+RQmq4DMYiFys2lXkSWkh0D3v9dLnzGb5xcY/X5D6mR6zj4URhzh6K91bUzyLigTIpm1vZr9FIP7jni+/HXJg=
X-Received: by 2002:a1c:e909:0:b0:3d1:e3ba:3bb6 with SMTP id
 q9-20020a1ce909000000b003d1e3ba3bb6mr730789wmc.29.1675546751084; Sat, 04 Feb
 2023 13:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <2302787.WOG5zRkYfl@silver> <CAFkjPTk=OwqKksY5AYzW4UOzKTbhg-GeWvVQtr0d_SU-F2GZQw@mail.gmail.com>
 <1675519496.NcNzUn7KHO@silver>
In-Reply-To: <1675519496.NcNzUn7KHO@silver>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Sat, 4 Feb 2023 15:38:59 -0600
Message-ID: <CAFkjPTm4SsB9rBX4ZZSZCYpiXgWYvQmViA_oALo5acdYNUUW2w@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Performance fixes for 9p filesystem
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net,
        Eric Van Hensbergen <ericvh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Okay, thanks for the additional detail - I have an idea of what the
problem might be.

As far as my tests - I've predominantly tested with dbench, fsx (with
and without mmap tests), postmark, and bonnie -- running single and
multithreaded.  All seem to work fine and didn't report errors.  I
thought the dbench trace was based on a build, but perhaps that's
inaccurate, or perhaps there's something peculiar with it being the
root file system (I have always just mounted it after boot, not tried
booting with it as root).

(thinking out loud)
In any case, I think the fact that we see that error when in readahead
mode is the key hint, because it means it thinks something is
writeback cached when it shouldn't be.  The writeback is triggered by
the setattr, which always calls filemap_write_and_wait -- this is all
old code, not something added by the change.  My assumption was that
if the inode had no dirty data (writebacks) then it would just not do
anything -- this should be the case in readahead mode.  So we gotta
figure out why it thinks it has dirty data.  Looking at the code where
the warning is printed, its a WARN_ONCE so its quite possible we are
hitting this left and right -- we can probably switch that to always
print to get an idea of this being the root cause.  Need to add some
more debug code to understand what we think we are writing back as
anything there should have been flushed when the file was closed.
To your multithreaded concern, I suppose there could be a race between
flushing mmap writes and the setattr also calling writeback, but the
folio is supposed to be locked at this point so you think there would
only be one writeback.  This will be easier to understand once I
reproduce and have a full trace and we know what file we are talking
about and what other operations might have been in flight.

There is a case in mmap that I was worried always required writeback,
but I did enough unit testing to convince myself that wasn't the case
-- so could be something down that path but will reproduce your
environment first and see if I can get the same types of error (I'm
most of the way there at this point, it is just we are digging out
from an ice storm here in texas so there's been more chainsawing than
coding....).

        -eric

On Sat, Feb 4, 2023 at 7:40 AM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> On Friday, February 3, 2023 8:12:14 PM CET Eric Van Hensbergen wrote:
> > Hi Christian, thanks for the feedback -- will dig in and see if I can
> > find what's gone south here.  Clearly my approach to writeback without
> > writeback_fid didn't cover all the corner cases and thats the cause of
> > the fault.  Can I get a better idea of how to reproduce - you booted
> > with a root 9p file system, and then tried to build...what?
>
> KDE, which builds numerous packages, multi-threaded by default. In the past we
> had 9p issues which triggered only after hours of compiling, however in this
> case I don't think that you need to build something fancy. Because it already
> fails at the very beginning of any build process, just when detecting a
> compiler.
>
> May I ask what kind of scenario you have tested so far? It was not a multi-
> threaded context, right? Large chunk or small chunk I/O?
>
> > Performance degradation is interesting, runs counter to the
> > unit-testing and benchmarking I did, but I didn't do something as
> > logical as a build to check -- need to tease apart whether this is a
> > read problem, a write problem...or both.  My intuition is that its on
> > the write side, but as part of going through the code I made the cache
> > code a lot more pessimistic so its possible I inadvertently killed an
> > optimistic optimization.
>
> I have not walked down the road to investigate individual I/O errors or even
> their cause yet, but from my feeling it could also be related to fid vs.
> writeback_fid. I saw you dropped a fix we made there last year, but haven't
> checked yet whether your changes would handle it correctly in another way.
>
> > Finally, just to clarify, the panic you had at the end happened with
> > readahead?  Seems interesting because clearly it thought it was
> > writing back something that it shouldn't have been writing back (since
> > writeback caches weren't enabled).   I'm thinking something was marked
> > as dirty even though the underlying system just wrote-through the
> > change and so the writeback isn't actually required.  This may also be
> > an indicator of the performance issue if we are actually writing
> > through the data in addition to an unnecessary write-back (which I
> > also worry is writing back bad data in the second case).
>
> It was not a kernel panic. It's a warning that appears right after boot, but
> the system continues to run. So that warning is printed before starting the
> actual build process. And yes, the warning is printed with "readahead".
>
> > Can you give me an idea of what the other misbehaviors were?
>
> There were really all sorts of misbheaviour on application level, e.g. no
> command history being available from shell (arrow up/down), things hanging on
> the shell for a long time, error messages. And after the writeahead test the
> build directory was screwed, i.e. even after rebooting with a regular kernel
> things no longer built correctly, so I had to restore a snapshot.
>
> Best regards,
> Christian Schoenebeck
>
>
