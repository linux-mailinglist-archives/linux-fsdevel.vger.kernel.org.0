Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEC41A8C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 19:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfEKRd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 13:33:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38544 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfEKRd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 13:33:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id 14so7637378ljj.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4GLGKJGBr1goNxWtth5dS3A9rH5i7tbT3DW+t/vUZM=;
        b=RiMckZqa7Pv2uJ6Jmq8WdsP1tgxvuMAA1KBrEXFSuTYRZg0dss6QUXLstX+qPl0cvi
         kW8HRPGc+o9zzUTLZU0Mhh/HlnQjlbSLAThZ8m9T+v+XaeUReplqMDf56AEvKd5qKIy7
         GzSd2O/qDYd43VAL+FXerAe7FQ27GBViWurwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4GLGKJGBr1goNxWtth5dS3A9rH5i7tbT3DW+t/vUZM=;
        b=VLzPtL7SCt8qzTepRUOXadakM8E1XvULQC8uIF3w4Nmh74ejxYqQ/IrXzd5cMah0Xv
         xVvL15kVnSAsJG8H5XO/PRp3WEYlCVxhYGREvp1vs0MASu6KOim6uvbv3nPtH6NpzMlE
         /ti9c7vLjvBL2ElL3Ks7tuFnMdoYu2FBqnFwECUlsn7jpvpeX8iOv8YDbUSwYlevcmVm
         MmKkXnb1bMfXn8yq0U5tF/Ryiy/qTX/Y6/tVvXgz34BsACbN3uQdUM6o6zxqTo6ViHNq
         ctGrZ+M+6cOpvUoHNEw5o7A5pusgR4IUkb3Zy9Vs0YxH8+JOniHY987BC/tNzlBejk4A
         8INQ==
X-Gm-Message-State: APjAAAX5zKYD8HTLR1AlnzpjdtuZ4jH1kdfoKBunb3iOT0ADvZmTx2c7
        KSQzW9lRCp3/d9/IBsJHJZ1zMvcOpNU=
X-Google-Smtp-Source: APXvYqyKdQ3wjt2gIpYgCI8AexiZhLQ+3mHMM7+zenew7dNkypRcMQp03F+RRaY1/7ShPQBGuaPYDA==
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr9328896lji.163.1557596006872;
        Sat, 11 May 2019 10:33:26 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 17sm2290271lji.2.2019.05.11.10.33.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 10:33:26 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w23so6260461lfc.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 10:33:26 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr9073466lfg.88.1557595631432;
 Sat, 11 May 2019 10:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 May 2019 13:26:55 -0400
X-Gmail-Original-Message-ID: <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com>
Message-ID: <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 11, 2019 at 1:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Notice? None of the real problems are about execve or would be solved
> by any spawn API. You just think that because you've apparently been
> talking to too many MS people that think fork (and thus indirectly
> execve()) is bad process management.

Side note: a good policy has been (and remains) to make suid binaries
not be dynamically linked. And in the absence of that, the dynamic
linker at least resets the library path when it notices itself being
dynamic, and it certainly doesn't inherit any open flags from the
non-trusted environment.

And by the same logic, a suid interpreter must *definitely* should not
inherit any execve() flags from the non-trusted environment. So I
think Aleksa's patch to use the passed-in open flags is *exactly* the
wrong thing to do for security reasons. It doesn't close holes, it
opens them.

                Linus
