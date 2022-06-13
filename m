Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D9D549B49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 20:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiFMSRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 14:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiFMSR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:17:27 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0E79D044
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 07:16:33 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id k4so6021554vsp.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Xo4qgctvoJuL+ohoNeKosmffvDgRddust02UtSA40w=;
        b=kNVJ12+0OCm8miHAX4pVQO8io5jonm0G7dbOgIOgUs0XV/88egwb1z6R04aMOqypah
         kBN6LSuEVeJr0aY4/jegTfc7pV5m6s16o2jGTcfoxTh88p+GtE9aRYdEyqjelH242SpL
         wkYgl+y9ki31BH9I4aDYxTYR4RDww54czBolkUrCTyBd0BiGAYWSa3bw/gv7WhgM00HI
         43du/TE6eVGPO2KhHbhY/ewS60N81o7M3iLmAXAJ64F8htjZcQ88JocF4ndcMSWHtfwH
         Wi1wS1SOtrxSnPDG77XdengZVCHl6iQt6qZpXrMThVduzho/9Pa8HXvOtjafACTytJF7
         4jzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Xo4qgctvoJuL+ohoNeKosmffvDgRddust02UtSA40w=;
        b=RX2QgwidZoDgaH3IvY6p1OyqvjrGtrSZ5ZKC3agm+8tgGY6nMfPfyF14Xh5uMSKYuW
         IIozey5ehznh1unL6y58a8PfpSH357OaPOUKlXQmzsVeY+/QcMEqpcQCxSBNM2K5Vijv
         VBB4p64fueystsWj6VMA+Kj4ZBEfjyie0v04Davfgftfo/b03Gi6iivRFCZDgEdga+oL
         QhJJLrieFNT73hqOCgnbFyPdzbXBbMGNoYXAJ09oiguSu6O1PsvE9G/jffWyHwfkS94j
         bIx8Ow6RECNl6RYK5HI8ILMqJ1kCs5jXGID9id1B3wZKYQYf06GQ+pQJqlVXoOfzFlQC
         hAcA==
X-Gm-Message-State: AOAM530ugOzaBYNsZraZYSwCsA8f2CcvuKSq9Q63Vc8uWm4ZCyoSnpEm
        umNAiMbvDGL5ULpMhkSskcm26dQxKyePrdw+EKkt0eHWfZ0dkA==
X-Google-Smtp-Source: ABdhPJzFer+JmRrK3TWhCXAwEFP0X1/kpbmQ0oPqvfDE22XP8k7uQfsfS3y9YSge0iK0lU73ik4Lg/SyDM0mluqhudQ=
X-Received: by 2002:a67:d28f:0:b0:34b:9225:6fda with SMTP id
 z15-20020a67d28f000000b0034b92256fdamr23317889vsi.72.1655129790894; Mon, 13
 Jun 2022 07:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220317141204.hbpflysc7p5e5vdo@quack3.lan>
 <CAOQ4uxh2KuLk21530upP0VYWDrks1m++0jfk6RGqGVayNnEHcg@mail.gmail.com>
 <CAOQ4uxhx=-RT_J-hiogPE9=LTyYVD2Q7FnZH03Hgba4Y3eh-QA@mail.gmail.com>
 <CAOQ4uxjuM4p7S6sg6R5=7skcKcC7GFcsrZ7ZftdadkLP4-Fk=g@mail.gmail.com> <20220613115909.fkprdllsxawc3trg@quack3.lan>
In-Reply-To: <20220613115909.fkprdllsxawc3trg@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 Jun 2022 17:16:19 +0300
Message-ID: <CAOQ4uxix2KJL135t32xabRXwVR8NwxJE9D_MrWt9sYFdVzDPbg@mail.gmail.com>
Subject: Re: LTP test for fanotify evictable marks
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 2:59 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 13-06-22 08:40:37, Amir Goldstein wrote:
> > On Sun, Mar 20, 2022 at 2:54 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Thu, Mar 17, 2022 at 5:14 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Thu, Mar 17, 2022 at 4:12 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Mon 07-03-22 17:57:36, Amir Goldstein wrote:
> > > > > > Jan,
> > > > > >
> > > > > > Following RFC discussion [1], following are the volatile mark patches.
> > > > > >
> > > > > > Tested both manually and with this LTP test [2].
> > > > > > I was struggling with this test for a while because drop caches
> > > > > > did not get rid of the un-pinned inode when test was run with
> > > > > > ext2 or ext4 on my test VM. With xfs, the test works fine for me,
> > > > > > but it may not work for everyone.
> > > > > >
> > > > > > Perhaps you have a suggestion for a better way to test inode eviction.
> > > > >
> > > > > Drop caches does not evict dirty inodes. The inode is likely dirty because
> > > > > you have chmodded it just before drop caches. So I think calling sync or
> > > > > syncfs before dropping caches should fix your problems with ext2 / ext4.  I
> > > > > suspect this has worked for XFS only because it does its private inode
> > > > > dirtiness tracking and keeps the inode behind VFS's back.
> > > >
> > > > I did think of that and tried to fsync which did not help, but maybe
> > > > I messed it up somehow.
> > > >
> > >
> > > You were right. fsync did fix the test.
> >
> > Hi Jan,
> >
> > I was preparing to post the LTP test for FAN_MARK_EVICTABLE [1]
> > and I realized the issue we discussed above was not really resolved.
> > fsync() + drop_caches is not enough to guarantee reliable inode eviction.
> >
> > It "kind of" works for ext2 and xfs, but not for ext4, ext3, btrfs.
> > "kind of" because even for ext2 and xfs, dropping only inode cache (2)
> > doesn't evict the inode/mark and dropping inode+page cache (3) does work
> > most of the time, although I did occasionally see failures.
> > I suspect those failures were related to running the test on a system
> > with very low page cache usage.
> > The fact that I had to tweak vfs_cache_pressure to increase test reliability
> > also suggests that there are heuristics at play.
>
> Well, yes, there's no guaranteed way to force inode out of cache. It is all
> best-effort stuff. When we needed to make sure inode goes out of cache on
> nearest occasion, we have introduced d_mark_dontcache() but there's no
> fs common way to set this flag on dentry and I don't think we want to
> expose one.
>
> I was thinking whether we have some more reliable way to test this
> functionality and I didn't find one. One other obvious approach to the test
> is to create memcgroup with low memory limit, tag large tree with evictable
> mark, and see whether the memory gets exhausted. This is kind of where this
> functionality is aimed. But there are also variables in this testing scheme
> that may be difficult to tame and the test will likely take rather long
> time to perform.

That's why I had the debugging FAN_IOC_SET_MARK_PAGE_ORDER
ioctl, which I used for a reliable and fast direct reclaim test.
Anyway, I am going to submit the test with the current kludges to run
on ext2 and see if anyone complains.

Thanks,
Amir.
