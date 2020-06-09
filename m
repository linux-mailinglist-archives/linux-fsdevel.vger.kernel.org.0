Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09721F31FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 03:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgFIB2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 21:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgFIB2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 21:28:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEC6C03E969;
        Mon,  8 Jun 2020 18:28:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so642736pjv.2;
        Mon, 08 Jun 2020 18:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/PrxdzanFtzivOl3Sfi1aaLSqEOyJZliRgx5aBR5kA8=;
        b=Z9r90gU9ch4ro1ELqinZ9peFG9SeQgLlzRhb+EOKO4g+fgXOyTTn783DcPbMndH2QX
         vo9SUTSg6L7uRuNCfall8o+o2y1EoFYfLxe4xoNZ602CgvDiRjz5jTs/U28krFQtCXfq
         t5JjqG/vARt2Z5qA0Su20/vzlrITjdHthHTcO3kbVEp20VotbXYdpWOfQL1YgbKCIhqi
         37XsWN9Mxz1U59mjG4DUziIFp713bzkRaopjJnbn99uL2dfSBKsmdW5VPrvenmvd7HYP
         yhTLm/PHNrTj3dmKfyeoYUhUVaN51X3ed1KJHTP6+ocaZtj5kXCqcW1nHBD15wUit2Qi
         Zhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/PrxdzanFtzivOl3Sfi1aaLSqEOyJZliRgx5aBR5kA8=;
        b=rI4YEx0hdSnKVL7Lcz6mRuyQFYgmvFJaxLfxE6Y/OhEe1jT0LV2YTtdjW69i0ojX4v
         h8Y9/VFb8eQYniTzD/DXIzBns+ed4PdTkLyAFxjYL3vF/gkDl+rfW1OzYv2Q6pHgx6Dm
         qZ2zSGR6bUK43/OQgO/kd8cfA5nM7PIOChm6KOrX69LNeiWDTshjFRRGPNf96r+c6COB
         rI6xCY9g+625iE+Xao8wqDMh5qzGMAzaOHjvhHMY9gU7pFUUchoY+via95yslF1x/EuC
         j5T/3h1e7/NyColSoqOhtWfUXFCWuK7QalwI6gFDhjKo6t1Dw8AlwlvOoUK8GBQtCbk/
         dmiA==
X-Gm-Message-State: AOAM533br4uPCFPhfPQz+XnG0bal3cA/qvySdTb87tOVDB9OgT96bIRp
        zWgsoo51mDOtriX8kLG/9Og=
X-Google-Smtp-Source: ABdhPJzfMCt7IHrLFWZyU8KJNkaWCbROB3mi7kvkG8AEBLpzWrGizA6jeZ/fMfQeHYAy0pQr7eksXw==
X-Received: by 2002:a17:90a:1d46:: with SMTP id u6mr2183173pju.146.1591666109952;
        Mon, 08 Jun 2020 18:28:29 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id i21sm6930297pgn.20.2020.06.08.18.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 18:28:29 -0700 (PDT)
Date:   Mon, 8 Jun 2020 18:28:26 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200609012826.dssh2lbfr6tlhwwa@ast-mbp.dhcp.thefacebook.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
 <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
 <af00d341-6046-e187-f5c8-5f57b40f017c@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af00d341-6046-e187-f5c8-5f57b40f017c@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 08:22:13AM +0900, Tetsuo Handa wrote:
> On 2020/06/09 1:23, Alexei Starovoitov wrote:
> > On Sun, Jun 07, 2020 at 11:31:05AM +0900, Tetsuo Handa wrote:
> >> On 2020/06/07 10:49, Alexei Starovoitov wrote:
> >>> So you're right that for most folks user space is the
> >>> answer. But there are cases where kernel has to have these things before
> >>> systemd starts.
> >>
> >> Why such cases can't use init= kernel command line argument?
> >> The program specified via init= kernel command line argument can do anything
> >> before systemd (a.k.a. global init process) starts.
> >>
> >> By the way, from the LSM perspective, doing a lot of things before global init
> >> process starts is not desirable, for access decision can be made only after policy
> >> is loaded (which is generally when /sbin/init on a device specified via root=
> >> kernel command line argument becomes ready). Since
> >> fork_usermode_blob((void *) "#!/bin/true\n", 12, info) is possible, I worry that
> >> the ability to start userspace code is abused for bypassing dentry/inode-based
> >> permission checks.
> > 
> > bpf_lsm is that thing that needs to load and start acting early.
> > It's somewhat chicken and egg. fork_usermode_blob() will start a process
> > that will load and apply security policy to all further forks and execs.
> 
> fork_usermode_blob() would start a process in userspace, but early in the boot
> stage means that things in the kernel might not be ready to serve for userspace
> processes (e.g. we can't open a shared library before a filesystem containing
> that file becomes ready, we can't mount a filesystem before mount point becomes
> ready, we can't access mount point before a device that contains that directory
> becomes ready).
> 
> TOMOYO LSM module uses call_usermodehelper() from tomoyo_load_policy() in order to
> load and apply security policy. What is so nice with fork_usermode_blob() compared
> to existing call_usermodehelper(), at the cost of confusing LSM modules by allowing
> file-less execve() request from fork_usermode_blob() ?

For the same reason you did commit 0e4ae0e0dec6 ("TOMOYO: Make several options configurable.")
Quoting your words from that commit:
"To be able to start using enforcing mode from the early stage of boot sequence,
 this patch adds support for activating access control without calling external
 policy loader program."
