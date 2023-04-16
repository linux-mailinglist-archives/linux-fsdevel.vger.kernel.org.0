Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138316E3622
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 10:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjDPInf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 04:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjDPIne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:43:34 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7171712;
        Sun, 16 Apr 2023 01:43:32 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id l13so152232uan.10;
        Sun, 16 Apr 2023 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681634612; x=1684226612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhR9Xuv7XBKFBY9afp9X2a/ZF6VAXaNCOKK5ItWapcA=;
        b=qg7mGTfqT3wrZx1Io9uHzOuDuCsVtAT9wGvXcYVa/++Wmo9l6He+CX4K0V+sSfRCAr
         +GD6EPEQDa6GN/c8PqwkcS8u8QvwpAc7dD9UUVxWBm+OIuo1W9hPjQGd2BN+wjxX3s7S
         xZV6USZncZY8n9Wm+LNPETEkzu3Q0yRQ/9v106lJ+Ygwpn7dawNxtCW+HQbFN8jHEW3a
         t9+myyYWknZgs+gArH1Ftit/deN2Nq13zrygYgarCd6hNnE7QHoGZQjkbhQRp4CEo9Is
         xhFFxIvX5ljD8dk8g2G3+FFyqKy3203aSTLSYZn8q4xUGddEGnplOEnEAxXOOtFsgNu/
         PWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681634612; x=1684226612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhR9Xuv7XBKFBY9afp9X2a/ZF6VAXaNCOKK5ItWapcA=;
        b=DxAhWGRZvs6PN551I2zZAINQZeEsn/ZGFTF4leoAg4OWU5Ow2pt9ejw6XqxQuVUkcS
         0FOCTNAvG1OHS1NdYD9bO6u+gYc3XlS6GtCu9gqKsyfKyto7PrffTKJCjLnNPgFn2YBB
         aTH7DwmUE1sXrlXF4A18QwG3o2pWoxXvfGVgVHA5SpiRECJ4gZdJ+SBOMCWGAmNVmqyD
         ak/7kLQbDqRXRLg7USCyQw2qCiybhWuslqkrrrSU/fz7RJ0bTkKkJAVaNWWsbin7c2YT
         2qWhsIiX+hCFTKM8Up98Vka31oSkBHQcKhAQzluuOHCtKoxo8purOi7oXLnyFweAQim6
         pKpA==
X-Gm-Message-State: AAQBX9cj8ZL7sM1IVb6Z8BFJMdj0t5LRIYnblCmnIHWf7y4WD4/99OMR
        5klAyjUFGJJA0OdUAxEoNTvjXEC8YzJbSUpVIrwdhcv/X2o=
X-Google-Smtp-Source: AKy350YbGqRAjcJKyLiAr/1j2fsF3gLUMmuNQJcbhmpsVtixi3NzR1q1cdwI+Db2/HTKjVbpqJ/8DNjf94jxn6A28ds=
X-Received: by 2002:a9f:3053:0:b0:771:f5ee:f4e with SMTP id
 i19-20020a9f3053000000b00771f5ee0f4emr6304992uab.1.1681634611942; Sun, 16 Apr
 2023 01:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <Y/5ovz6HI2Z47jbk@magnolia> <9b689664-095c-f2cf-7ba5-86303df3722b@gmx.com>
In-Reply-To: <9b689664-095c-f2cf-7ba5-86303df3722b@gmx.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 16 Apr 2023 11:43:21 +0300
Message-ID: <CAOQ4uxgV5LiUdJqAGDaGyCUMSM9LG+CBbj0sS8-ZVHw-Q+Y7yg@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] online repair of filesystems: what next?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 16, 2023 at 11:11=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> On 2023/3/1 04:49, Darrick J. Wong wrote:
> > Hello fsdevel people,
> >
> > Five years ago[0], we started a conversation about cross-filesystem
> > userspace tooling for online fsck.  I think enough time has passed for
> > us to have another one, since a few things have happened since then:
> >
> > 1. ext4 has gained the ability to send corruption reports to a userspac=
e
> >     monitoring program via fsnotify.  Thanks, Collabora!
>
> Not familiar with the new fsnotify thing, any article to start?

https://docs.kernel.org/admin-guide/filesystem-monitoring.html#file-system-=
error-reporting

fs needs to opt-in with fsnotify_sb_error() calls and currently, only
ext4 does that.

>
> I really believe we should have a generic interface to report errors,
> currently btrfs reports extra details just through dmesg (like the
> logical/physical of the corruption, reason, involved inodes etc), which
> is far from ideal.
>
> >
> > 2. XFS now tracks successful scrubs and corruptions seen during runtime
> >     and during scrubs.  Userspace can query this information.
> >
> > 3. Directory parent pointers, which enable online repair of the
> >     directory tree, is nearing completion.
> >
> > 4. Dave and I are working on merging online repair of space metadata fo=
r
> >     XFS.  Online repair of directory trees is feature complete, but we
> >     still have one or two unresolved questions in the parent pointer
> >     code.
> >
> > 5. I've gotten a bit better[1] at writing systemd service descriptions
> >     for scheduling and performing background online fsck.
> >
> > Now that fsnotify_sb_error exists as a result of (1), I think we
> > should figure out how to plumb calls into the readahead and writeback
> > code so that IO failures can be reported to the fsnotify monitor.  I
> > suspect there may be a few difficulties here since fsnotify (iirc)
> > allocates memory and takes locks.
> >
> > As a result of (2), XFS now retains quite a bit of incore state about
> > its own health.  The structure that fsnotify gives to userspace is very
> > generic (superblock, inode, errno, errno count).  How might XFS export
> > a greater amount of information via this interface?  We can provide
> > details at finer granularity -- for example, a specific data structure
> > under an allocation group or an inode, or specific quota records.
>
> The same for btrfs.
>
> Some btrfs specific info like subvolume id is also needed to locate the
> corrupted inode (ino is not unique among the full fs, but only inside
> one subvolume).
>

The fanotify error event (which btrfs does not currently generate)
contains an "FID record", FID is fsid+file_handle.
For btrfs, file_handle would be FILEID_BTRFS_WITHOUT_PARENT
so include the subvol root ino.

> And something like file paths for the corrupted inode is also very
> helpful for end users to locate (and normally delete) the offending inode=
.
>

This interface was merged without the ability to report an fs-specific
info blob, but it was designed in a way that would allow adding that blob.

Thanks,
Amir.
