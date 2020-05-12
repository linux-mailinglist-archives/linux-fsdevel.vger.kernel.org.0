Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655521D001C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 23:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgELVGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 17:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELVGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 17:06:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E848C061A0C
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 14:06:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so6387728pfa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 14:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=j5G1rGAozMzMgyU1JqMyrq0LCgr5U8CbIe+eoAehnBE=;
        b=fWqISwwRV1Cp0p3hEIqz2JPs/e51xAIhgluD2cuw0MLbuwAWZiAixmlmK1amD62n0U
         zEQ5N4AJ8vz2XOrZ+RhHCzUw5fVQcoBhK7chafzRSx6BalK67W842qUqQqIuEGuNgMus
         4D8mn/v3Y3cMZJodmDA2PR3tRpAyvxPruVwsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j5G1rGAozMzMgyU1JqMyrq0LCgr5U8CbIe+eoAehnBE=;
        b=kRVRaVGNuJOkxVpommB72weT/STnRD+fUqH3V6OBOu3xGP5BMniYllyBYyznjfmnHk
         cg8TbPQ7eF+pePrJc73TCUxbs5s3ueVp9Rqbn65OuBlxMtTJ4AG4cyqgI3xXuOLuf28r
         qMLq+zr9DaoyKikq8VFo16Gmsc8+q8Ai5oHFqmCzNzKMYnMwi2H5ieuo/BGmZvz9pyWL
         8r0+pED506jJwhPNukWdRA1kWO8ZE/Xq8oPq8tJGO2Upa0AdTW0osykpI3FhGM3xLcRu
         fJrmAOCCfZJLiWwxh/E6747dAJP+p7hhrUS+vvJLVDAycPM1FF6uYeq6leaOg1tVGprO
         c5ow==
X-Gm-Message-State: AGi0PuYL1gaTWzQaiTIgDqkNjbJkzkbKp8gvaORMTVnAUVNVSqAr9Jjb
        MkiyFhrk4lmOV8nb7kGQz9xwxA==
X-Google-Smtp-Source: APiQypKxymAGHHHmKkMira04oLA2EHbqSrasctJGjgDtYRDvErfuyi2FNoZWH/riiCdh9qC4B+d6Ug==
X-Received: by 2002:a63:111e:: with SMTP id g30mr20764600pgl.446.1589317561085;
        Tue, 12 May 2020 14:06:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p9sm4128699pgb.19.2020.05.12.14.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:05:59 -0700 (PDT)
Date:   Tue, 12 May 2020 14:05:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] fs: Add support for an O_MAYEXEC flag on
 openat2(2)
Message-ID: <202005121258.4213DC8A2@keescook>
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-2-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505153156.925111-2-mic@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 05:31:51PM +0200, Mickaël Salaün wrote:
> When the O_MAYEXEC flag is passed, openat2(2) may be subject to
> additional restrictions depending on a security policy managed by the
> kernel through a sysctl or implemented by an LSM thanks to the
> inode_permission hook.  This new flag is ignored by open(2) and
> openat(2).
> 
> The underlying idea is to be able to restrict scripts interpretation
> according to a policy defined by the system administrator.  For this to
> be possible, script interpreters must use the O_MAYEXEC flag
> appropriately.  To be fully effective, these interpreters also need to
> handle the other ways to execute code: command line parameters (e.g.,
> option -e for Perl), module loading (e.g., option -m for Python), stdin,
> file sourcing, environment variables, configuration files, etc.
> According to the threat model, it may be acceptable to allow some script
> interpreters (e.g. Bash) to interpret commands from stdin, may it be a
> TTY or a pipe, because it may not be enough to (directly) perform
> syscalls.  Further documentation can be found in a following patch.

You touch on this lightly in the cover letter, but it seems there are
plans for Python to restrict stdin parsing? Are there patches pending
anywhere for other interpreters? (e.g. does CLIP OS have such patches?)

There's always a push-back against adding features that have external
dependencies, and then those external dependencies can't happen without
the kernel first adding a feature. :) I like getting these catch-22s
broken, and I think the kernel is the right place to start, especially
since the threat model (and implementation) is already proven out in
CLIP OS, and now with IMA. So, while the interpreter side of this is
still under development, this gives them the tool they need to get it
done on the kernel side. So showing those pieces (as you've done) is
great, and I think finding a little bit more detail here would be even
better.

> A simple security policy implementation, configured through a dedicated
> sysctl, is available in a following patch.
> 
> This is an updated subset of the patch initially written by Vincent
> Strubel for CLIP OS 4:
> https://github.com/clipos-archive/src_platform_clip-patches/blob/f5cb330d6b684752e403b4e41b39f7004d88e561/1901_open_mayexec.patch
> This patch has been used for more than 11 years with customized script
> interpreters.  Some examples (with the original name O_MAYEXEC) can be
> found here:
> https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
> Signed-off-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>

nit: this needs to be reordered. It's expected that the final SoB
matches the sender. If you're trying to show co-authorship, please
see:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Based on what I've inferred about author ordering, I think you want:

Co-developed-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
Signed-off-by: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
Co-developed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Signed-off-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Co-developed-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Mickaël Salaün <mic@digikod.net>

> Reviewed-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>

Everything else appears good to me, but Al and Aleksa know VFS internals
way better. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
