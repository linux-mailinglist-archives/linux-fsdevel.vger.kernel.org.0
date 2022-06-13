Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DD6547F12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 07:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiFMFoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 01:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbiFMFnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:43:10 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E44E13D7A
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jun 2022 22:40:50 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id g6so4894339vsb.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jun 2022 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0bYlsh+RbjmYUR9Jg/kpe6pj6lKuZexZE/egZa6lT4=;
        b=GFlonUvq158L9htFNygN9DUTfNk0DUMAbREFEsy9BSSKGvDZZAV2nvfnNtZrORwbRq
         uaq7cMa5qmW2hTkiyZA+latUYUdzjhUnvzvKaAfYoTQIYZ69WXAeiPPR6c6NemdG8utc
         S8og8puoT2V+T/tq0b56KI25cPi8Zx+QIKmGvYGwaumn6BhA8ms46yYDQJDQ5y2fUW/S
         6vsPzRNgwdjF5VGs84Wo1TWYIIvAXS40DqQTBKTSi+BEohcKmWKjFGFS75g0MVNHcreY
         7uy5BTICPs8rK+8VtXx0DhYke9gcvhWk8VayGUcHeCwbyFDBYtBxdB0+NxVy2hlL65iE
         nT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0bYlsh+RbjmYUR9Jg/kpe6pj6lKuZexZE/egZa6lT4=;
        b=0/9rYaoDCzmr/KOc5QhFP7D39DMcbm4fWsh47uaA0nr1UDbNQ65UYsfZztY0jQzTZB
         i7fbP7+Xb2gPEKetq2BXN2qzuy+HVPeVUvhypKYtIuzyJxeyvomVz7FseUoOdiARhK4i
         bLvjZG6E0z02Z+XV+HB1Vk8Ld4BJa6NibNCAy7RiySfm6eEpQLgBWrX5VqoUToK2T1Kj
         1EZVfuwvXgdMR8bKJymwFmMZinO0BdVULb10rkxBx4v6ife1MygglCTf/yFYy8pSaDCe
         QNEiikSPT2yOqsb5HVqmsxSHRHQ2eFKd/wW7aOs9IRY6OihFIRMRVgHAVTrSzRb0e8Ti
         +7ZA==
X-Gm-Message-State: AOAM531vli8AHa+2YmdognBDIiTlzu/xoWuTdHKNlJKal9rVMhD8s64N
        lPsoVenM2xvMnhGfL/FYAFdL0K/7nRz7nYEOdTljGkbD/qt8Ag==
X-Google-Smtp-Source: ABdhPJy71VK0VlyAv+DDfevPfMpZ0Z9eprZh8QBVihFyBmtnJLRbPlFkIW/UkUHu88JEz5VAU2QyU33BaCzM8XKB7f4=
X-Received: by 2002:a67:486:0:b0:349:e59c:51f4 with SMTP id
 128-20020a670486000000b00349e59c51f4mr25419876vse.3.1655098849602; Sun, 12
 Jun 2022 22:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220317141204.hbpflysc7p5e5vdo@quack3.lan>
 <CAOQ4uxh2KuLk21530upP0VYWDrks1m++0jfk6RGqGVayNnEHcg@mail.gmail.com> <CAOQ4uxhx=-RT_J-hiogPE9=LTyYVD2Q7FnZH03Hgba4Y3eh-QA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhx=-RT_J-hiogPE9=LTyYVD2Q7FnZH03Hgba4Y3eh-QA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 13 Jun 2022 08:40:37 +0300
Message-ID: <CAOQ4uxjuM4p7S6sg6R5=7skcKcC7GFcsrZ7ZftdadkLP4-Fk=g@mail.gmail.com>
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

On Sun, Mar 20, 2022 at 2:54 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Mar 17, 2022 at 5:14 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Mar 17, 2022 at 4:12 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 07-03-22 17:57:36, Amir Goldstein wrote:
> > > > Jan,
> > > >
> > > > Following RFC discussion [1], following are the volatile mark patches.
> > > >
> > > > Tested both manually and with this LTP test [2].
> > > > I was struggling with this test for a while because drop caches
> > > > did not get rid of the un-pinned inode when test was run with
> > > > ext2 or ext4 on my test VM. With xfs, the test works fine for me,
> > > > but it may not work for everyone.
> > > >
> > > > Perhaps you have a suggestion for a better way to test inode eviction.
> > >
> > > Drop caches does not evict dirty inodes. The inode is likely dirty because
> > > you have chmodded it just before drop caches. So I think calling sync or
> > > syncfs before dropping caches should fix your problems with ext2 / ext4.  I
> > > suspect this has worked for XFS only because it does its private inode
> > > dirtiness tracking and keeps the inode behind VFS's back.
> >
> > I did think of that and tried to fsync which did not help, but maybe
> > I messed it up somehow.
> >
>
> You were right. fsync did fix the test.

Hi Jan,

I was preparing to post the LTP test for FAN_MARK_EVICTABLE [1]
and I realized the issue we discussed above was not really resolved.
fsync() + drop_caches is not enough to guarantee reliable inode eviction.

It "kind of" works for ext2 and xfs, but not for ext4, ext3, btrfs.
"kind of" because even for ext2 and xfs, dropping only inode cache (2)
doesn't evict the inode/mark and dropping inode+page cache (3) does work
most of the time, although I did occasionally see failures.
I suspect those failures were related to running the test on a system with very
low page cache usage.
The fact that I had to tweak vfs_cache_pressure to increase test reliability
also suggests that there are heuristics at play.

I guess I could fill the page cache with pages to rig the game.
Do you have other suggestions on how to increase the reliability of the test?
That is, how to reliably evict a non-dirty inode.

Thanks,
Amir.

[1] https://github.com/amir73il/ltp/blob/fan_evictable/testcases/kernel/syscalls/fanotify/fanotify23.c
