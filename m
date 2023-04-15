Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8895C6E315B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 14:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDOMSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDOMSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:18:18 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0BF30C1;
        Sat, 15 Apr 2023 05:18:17 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id y13so19278708vss.0;
        Sat, 15 Apr 2023 05:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681561096; x=1684153096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSJMPcUMeTzCmFG5vIa5QVDKVDZ9UTF4q/kaI+qDjNw=;
        b=gkNz5oGp/vBggcE1Met2bHglt3dt9PWfnChfy2+ApEf7KqYRLf6TCNkijT1w8SjNYB
         5At1uoRq0NkrSKX90YOG+OM4yLzbFfyzEObN9SD/vX0WeqL+IdjXlH5GcOrLcoqgSHLu
         orYv54APwg920xDK87Cu6vWeGTGxfgvgFW2W6RX8SWHvfj1Enmrt6D3bbq2YxgPZwDbN
         KyQ2+V0s3Us4s52E4oqzn19EYVlsbF3moMLTvRQHVvK2CB11+5Q0RpapfeXrV+eJKWkO
         6zpi0bK8dJ4bdNBOOGpIaKLhhQG2chyh+zLPZxyCaxMmX8gIJpqFisRKGukQAKNflGEu
         +hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681561096; x=1684153096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSJMPcUMeTzCmFG5vIa5QVDKVDZ9UTF4q/kaI+qDjNw=;
        b=bkFZD8nk0RjKmqKgyYWlcEjPXpfaF+m9O/dnfzcbVKIVQh5mCGF0iPX5BhSlXqlmwB
         VfcQVAZJiR8wq1pyk/f2lXTMC9VMEthDr73h5m3OGA+cvLAz8kx3HmHrqWoK0eyEF6ER
         rwDPTwu+JFvSuVHk+dcDcLjE8OQnNmPYz2HryO4g6BaYFojDqI/Rccr/RP7TqSVEdECv
         KxYm8JYnwvHSVyJwFsCwBAiLonq+Mu2aU/5xSON/S6oTdHFs5kYrzbZBTUK3XWt7oUpO
         EM90Os7wuPaDC3jmw1DSPQ9deo2RDT5PnE8Uzd/oL/sNjjeynRGtCcoFDGZ1AhzOl82Z
         ch5A==
X-Gm-Message-State: AAQBX9eB/xllzbDaGBHgBKZBX1Veyf6LKRH4ezhUcu7ujxFByE8A62KJ
        eppc97esHknHdRR1Ak655JvBiztTnQe3wB+RYUDliTjLM/4=
X-Google-Smtp-Source: AKy350Zv/FpRe2kGL4keuqhS/Mwb6KH/4RHtGa+6+5n2BgBo6RIalKonvfwNksy6LSpTb+BCT+gqChysJTfXEP1hwq4=
X-Received: by 2002:a67:d99e:0:b0:42e:63a5:c0d6 with SMTP id
 u30-20020a67d99e000000b0042e63a5c0d6mr244704vsj.0.1681561096226; Sat, 15 Apr
 2023 05:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <Y/5ovz6HI2Z47jbk@magnolia>
In-Reply-To: <Y/5ovz6HI2Z47jbk@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 15 Apr 2023 15:18:05 +0300
Message-ID: <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] online repair of filesystems: what next?
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 10:49=E2=80=AFPM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> Hello fsdevel people,
>
> Five years ago[0], we started a conversation about cross-filesystem
> userspace tooling for online fsck.  I think enough time has passed for
> us to have another one, since a few things have happened since then:
>
> 1. ext4 has gained the ability to send corruption reports to a userspace
>    monitoring program via fsnotify.  Thanks, Collabora!
>
> 2. XFS now tracks successful scrubs and corruptions seen during runtime
>    and during scrubs.  Userspace can query this information.
>
> 3. Directory parent pointers, which enable online repair of the
>    directory tree, is nearing completion.
>
> 4. Dave and I are working on merging online repair of space metadata for
>    XFS.  Online repair of directory trees is feature complete, but we
>    still have one or two unresolved questions in the parent pointer
>    code.
>
> 5. I've gotten a bit better[1] at writing systemd service descriptions
>    for scheduling and performing background online fsck.
>
> Now that fsnotify_sb_error exists as a result of (1), I think we
> should figure out how to plumb calls into the readahead and writeback
> code so that IO failures can be reported to the fsnotify monitor.  I
> suspect there may be a few difficulties here since fsnotify (iirc)
> allocates memory and takes locks.
>
> As a result of (2), XFS now retains quite a bit of incore state about
> its own health.  The structure that fsnotify gives to userspace is very
> generic (superblock, inode, errno, errno count).  How might XFS export
> a greater amount of information via this interface?  We can provide
> details at finer granularity -- for example, a specific data structure
> under an allocation group or an inode, or specific quota records.
>
> With (4) on the way, I can envision wanting a system service that would
> watch for these fsnotify events, and transform the error reports into
> targeted repair calls in the kernel.  This of course would be very
> filesystem specific, but I would also like to hear from anyone pondering
> other usecases for fsnotify filesystem error monitors.
>
> Once (3) lands, XFS gains the ability to translate a block device IO
> error to an inode number and file offset, and then the inode number to a
> path.  In other words, your file breaks and now we can tell applications
> which file it was so they can failover or redownload it or whatever.
> Ric Wheeler mentioned this in 2018's session.
>
> The final topic from that 2018 session concerned generic wrappers for
> fsscrub.  I haven't pushed hard on that topic because XFS hasn't had
> much to show for that.  Now that I'm better versed in systemd services,
> I envision three ways to interact with online fsck:
>
> - A CLI program that can be run by anyone.
>
> - Background systemd services that fire up periodically.
>
> - A dbus service that programs can bind to and request a fsck.
>
> I still think there's an opportunity to standardize the naming to make
> it easier to use a variety of filesystems.  I propose for the CLI:
>
> /usr/sbin/fsscrub $mnt that calls /usr/sbin/fsscrub.$FSTYP $mnt
>
> For systemd services, I propose "fsscrub@<escaped mountpoint>".  I
> suspect we want a separate background service that itself runs
> periodically and invokes the fsscrub@$mnt services.  xfsprogs already
> has a xfs_scrub_all service that does that.  The services are nifty
> because it's really easy to restrict privileges, implement resource
> usage controls, and use private name/mountspaces to isolate the process
> from the rest of the system.
>
> dbus is a bit trickier, since there's no precedent at all.  I guess
> we'd have to define an interface for filesystem "object".  Then we could
> write a service that establishes a well-known bus name and maintains
> object paths for each mounted filesystem.  Each of those objects would
> export the filesystem interface, and that's how programs would call
> online fsck as a service.
>
> Ok, that's enough for a single session topic.  Thoughts? :)

Darrick,

Quick question.
You indicated that you would like to discuss the topics:
Atomic file contents exchange
Atomic directio writes

Are those intended to be in a separate session from online fsck?
Both in the same session?

I know you posted patches for FIEXCHANGE_RANGE [1],
but they were hiding inside a huge DELUGE and people
were on New Years holidays, so nobody commented.

Perhaps you should consider posting an uptodate
topic suggestion to let people have an opportunity to
start a discussion before LSFMM.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/167243843494.699466.5163281976943=
635014.stgit@magnolia/
