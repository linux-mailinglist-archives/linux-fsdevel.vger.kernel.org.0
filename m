Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1420A66E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 22:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404483AbgFYUMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 16:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404386AbgFYUMy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:12:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD78C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2020 13:12:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so3931058lfb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2020 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Y46LuyszRq3BVDcnDZ7ReMKh01CyKQeI5H/cI3VLxk=;
        b=J5byxCRhw8+TkCbEEX9a2LCot84or8NLorXcpY6WIPYJgEH1/Ekqt/WBSlkEK7LT+G
         bndLltQGjYgsXZkIYv7U4HSD9vfzZSX8iMP12sM3dBtFd72w9tGCUJISUrKFiIs2jlCB
         kdg2Oz6CwCOocpL1P4O2BRetDEcG44U2iMwyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Y46LuyszRq3BVDcnDZ7ReMKh01CyKQeI5H/cI3VLxk=;
        b=a6ut+MRRPlKEOatlfmxSiQBYN+q9FKkfVyguaQGn3bHe47AVtBJPgNPODjrghbhe6U
         4IUCJatobn0DFkfgZRsEQRcSo1Aovc5QhfxpwTZqFPjVmg1MVNmltxNjKRqVOy/yIzlN
         SdzMVlMiingQKY4kskM1mkSWYgnSjP9IG+epuOl0ZqYDnLfxJIOyBEZRNq4b876CtMGQ
         0EiKdSB1xUUPvgDUBDq9vc2234+b5qIHTt7tCT3RpzgaMFNH5geHJcCz3U9Y4lyeyQUb
         UhBI8ke0k4XkX0N4r/rn8sbfRSAyEpgOmMKYHayQj/g9P6i+vLRrr741OF3k/C/EP9WK
         wx7Q==
X-Gm-Message-State: AOAM533fPuNySFoeQfM/jVuBiVcTmPojh4hnwEpQcw5P5nwyVFlPZQ4X
        /kXYHHvfiAjL1mCxq7FB2ZREnL2lmic=
X-Google-Smtp-Source: ABdhPJwUV6lrUJbMu+mw/I+QXwRBZsA6DEHsIxY2JaYQtVRKPA/jEg6ZIra0zncEiPysXAj2yYvzrQ==
X-Received: by 2002:a05:6512:10d3:: with SMTP id k19mr19803881lfg.78.1593115972064;
        Thu, 25 Jun 2020 13:12:52 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x11sm6192339lfq.23.2020.06.25.13.12.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 13:12:51 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id x18so7962574lji.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2020 13:12:50 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr18125829ljj.312.1593115970627;
 Thu, 25 Jun 2020 13:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200625181948.GF17788@quack2.suse.cz>
In-Reply-To: <20200625181948.GF17788@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Jun 2020 13:12:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8XGkaPe1+ROAMUPK3Gfcx_tQY+RzUuSwksJepz8pQkQ@mail.gmail.com>
Message-ID: <CAHk-=wj8XGkaPe1+ROAMUPK3Gfcx_tQY+RzUuSwksJepz8pQkQ@mail.gmail.com>
Subject: Re: [GIT PULL] fsnotify speedup for 5.8-rc3
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:19 AM Jan Kara <jack@suse.cz> wrote:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.8-rc3
>
> to get a performance improvement to reduce impact of fsnotify for inodes
> where it isn't used.

Pulled.

I do note that there's some commonality here with commit ef1548adada5
("proc: Use new_inode not new_inode_pseudo") and the discussion there
around "maybe new_inode_pseudo should disable fsnotify instead".

See

    https://lore.kernel.org/lkml/CAHk-=wh7nZNf81QPcgpDh-0jzt2sOF3rdUEB0UcZvYFHDiMNkw@mail.gmail.com/

and in particular the comment there:

        I do wonder if we should have kept the new_inode_pseudo(),
    and instead just make fsnotify say "you can't notify on an inode that
    isn't on the superblock list"

 which is kind of similar to this alloc_file_pseudo() change..

There it wasn't so much about performance, as about an actual bug
(quoting from that commit):

    Recently syzbot reported that unmounting proc when there is an ongoing
    inotify watch on the root directory of proc could result in a use
    after free when the watch is removed after the unmount of proc
    when the watcher exits.

but the fnsotify connection and the "pseudo files/inodes can't be
notified about" is the same.

Comments?

               Linus
