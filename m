Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633EC2149B2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 04:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgGECqm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 22:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgGECql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 22:46:41 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B869BC061794;
        Sat,  4 Jul 2020 19:46:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g37so5501668otb.9;
        Sat, 04 Jul 2020 19:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E53jDZaWWL2m81Ppybls7LxIkJox19KnU003mBoW+40=;
        b=ssPl4zuIwOlMx9wCkmm52mHTPbSodV15CQPxHhtnh1wp9MBNuyzQss/Lh8nZED2h2r
         rXN73lftKU6BG3K+KFLIE37DVXpXU25DF5ArybQgG3k9N0k++lnuozJgm9xd8s6iLFhk
         tJlCk+aeCTW0tDN9u5PxEezKEm7que1Ygt9HkpJi/PbUWRKpaVEIiEgyH7wSabKWIOD+
         h6sjR4NmHP37to18535jnS0svOcvHUeXJ0SFO64ptW5EF4N38JnTL/0kSVluhThmVmWi
         BcLNoIovqT+8mQW6ygxt2XhzYVBl+HMV6cKT6hc5g1Z6YZmTbyhVgLJA+3RMIsKWcA8I
         cvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E53jDZaWWL2m81Ppybls7LxIkJox19KnU003mBoW+40=;
        b=W/Iy0iYbijHJUC+09amSsqxfcLMwL0thhfTWS/p1edHh72QqWUgN7sN6UsvxGr9zwu
         Bc1IboCswL1VfpAZvh6nvHIGZMUfkQ4g72+hLbHXa/oNQ2Q8c5yBAunC2azi2rKEJAWK
         5gM87mO1eGo9o6I0TCD4g8y8wTXyUGwBOm2hAkgMUj3eLUw/uXnZddz9yiWitahPhMz1
         n6AKet4XVm5jbtGX4lMsTyezPh809Xaq0VOIxlFKaG70DcRnE9cQa9TMr3yadaF6G/la
         /U+CNaXz3jspVuGPYZvUZqEJeRPOA7AmtpSYV8IrjmcXjlFAmVyk8iaIjf4vfsiRcmXj
         iCNQ==
X-Gm-Message-State: AOAM530Jjf1exN+bq+cdUEGA9pUizABU+ipLURJlc4BCGmlJ6B/fqdJI
        GKN3WQd2m191WombRzKBDZ7F/HwI96eGIqjqZ/U=
X-Google-Smtp-Source: ABdhPJxnI6oRywmjWNvF7YTeEWGlfdMx/Xk6t7WM1gAUyf5ZCyVkvZgHajkDpcySKwrdUqmrIx3bvAjss4CWllE/aQo=
X-Received: by 2002:a9d:4d1a:: with SMTP id n26mr26986993otf.54.1593917201031;
 Sat, 04 Jul 2020 19:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org>
In-Reply-To: <20200705021631.GR25523@casper.infradead.org>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sun, 5 Jul 2020 04:46:04 +0200
Message-ID: <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close faster
To:     Matthew Wilcox <willy@infradead.org>
Cc:     gregkh@linuxfoundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 5, 2020 at 4:16 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jul 05, 2020 at 04:06:22AM +0200, Jan Ziak wrote:
> > Hello
> >
> > At first, I thought that the proposed system call is capable of
> > reading *multiple* small files using a single system call - which
> > would help increase HDD/SSD queue utilization and increase IOPS (I/O
> > operations per second) - but that isn't the case and the proposed
> > system call can read just a single file.
> >
> > Without the ability to read multiple small files using a single system
> > call, it is impossible to increase IOPS (unless an application is
> > using multiple reader threads or somehow instructs the kernel to
> > prefetch multiple files into memory).
>
> What API would you use for this?
>
> ssize_t readfiles(int dfd, char **files, void **bufs, size_t *lens);
>
> I pretty much hate this interface, so I hope you have something better
> in mind.

I am proposing the following:

struct readfile_t {
  int dirfd;
  const char *pathname;
  void *buf;
  size_t count;
  int flags;
  ssize_t retval; // set by kernel
  int reserved; // not used by kernel
};

int readfiles(struct readfile_t *requests, size_t count);

Returns zero if all requests succeeded, otherwise the returned value
is non-zero (glibc wrapper: -1) and user-space is expected to check
which requests have succeeded and which have failed. retval in
readfile_t is set to what the single-file readfile syscall would
return if it was called with the contents of the corresponding
readfile_t struct.

The glibc library wrapper of this system call is expected to store the
errno in the "reserved" field. Thus, a programmer using glibc sees:

struct readfile_t {
  int dirfd;
  const char *pathname;
  void *buf;
  size_t count;
  int flags;
  ssize_t retval; // set by glibc (-1 on error)
  int errno; // set by glibc if retval is -1
};

retval and errno in glibc's readfile_t are set to what the single-file
glibc readfile would return (retval) and set (errno) if it was called
with the contents of the corresponding readfile_t struct. In case of
an error, glibc will pick one readfile_t which failed (such as: the
1st failed one) and use it to set glibc's errno.
