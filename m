Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4938220738
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 10:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGOI34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 04:29:56 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:44168 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgGOI34 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:29:56 -0400
Received: by mail-oo1-f67.google.com with SMTP id o36so296646ooi.11;
        Wed, 15 Jul 2020 01:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kAaWMwZVt1TtW+VGsV2swIGSOLuHPRWZdlu1mnnD68=;
        b=p9OZ6Iu0jh5WfBQsqaTlVSavALis1LsKKO/xuokFTPGYw2sj9jUnCmzkf0TY7RwWdx
         YGA64QHn6EWR3qWgyqkzSRLtTDgQXKKcM16q5vpjJUKhJ67NZ9Oy7KIFm9Bx0xkrdiXT
         IkT9jHq2RtYpCiMiNdajfy9PsX/7ew0vQUJZi6jghMuYPtePh74GTi2V1lHe1z5QvSOA
         bpjURc7RCQPfPsRAZ/RujLSrdICsXyInOW1eVUCZyQjlDsiS1cnVNrOG0CaYKtm7sU67
         QeFL8uB2ISscpisPmu5e5ugyUvz9DTvubey0i1QQ0yoMDt1UHUqkptEmd+MaLICWT4G7
         Qhkg==
X-Gm-Message-State: AOAM531NT7YaPju+Ar0ahMBwh1wF28C+fHWNh+AaZosIGvEyUHLVTZ2W
        +xpKeCgigzLNkwgHjeegy2rIRAkPbMUPuFAarBY=
X-Google-Smtp-Source: ABdhPJw2kyhJB1Q8I9moIhAMt6CsrMmz+dmXrIDcOSx9Lq+GKqzeucCTLSaJdLMMsmWVmuXHh1UZfBsTqdM8Ql684Zg=
X-Received: by 2002:a4a:9552:: with SMTP id n18mr8265150ooi.1.1594801794967;
 Wed, 15 Jul 2020 01:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200714161415.3886463-1-christian.brauner@ubuntu.com> <20200714161415.3886463-5-christian.brauner@ubuntu.com>
In-Reply-To: <20200714161415.3886463-5-christian.brauner@ubuntu.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 10:29:43 +0200
Message-ID: <CAMuHMdXt4Fs68devt=SQAL0pWMtdeyQZo_4tHMOGDFN9V02JtQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] fs: add mount_setattr()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 6:17 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> This implements the mount_setattr() syscall. While the new mount api
> allows to change the properties of a superblock there is currently no
> way to change the mount properties of a mount or mount tree using mount
> file descriptors which the new mount api is based on. In addition the
> old mount api has the restriction that mount options cannot be
> applied recursively. This hasn't changed since changing mount options on
> a per-mount basis was implemented in [1] and has been a frequent
> request.

[...]

> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

>  arch/m68k/kernel/syscalls/syscall.tbl       |   1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
