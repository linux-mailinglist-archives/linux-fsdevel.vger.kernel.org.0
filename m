Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353EF42FD8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 23:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbhJOVmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 17:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbhJOVmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:42:12 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6065C061762
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 14:40:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r2so9706662pgl.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Oct 2021 14:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OC+jrW9oR+voHLlcIgtL+Hx7Y3DP99pyeUNwSFX1ZM8=;
        b=IUdMwgdbWX72NRfCvu1lU6iZI/MN31tWWtZfEjIQlGVSSFzxbnmKvtaHdZBQbl3aGJ
         YhV4UoZm6db53Mto8Mx/EQF4SL9skUWdeWIdaUpeY6KtD6oV07URNiJiKMVQcz6+Sawr
         jMbJ5F+fY36tt/3gcIFxUqOMEjRnhbeaGuuI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OC+jrW9oR+voHLlcIgtL+Hx7Y3DP99pyeUNwSFX1ZM8=;
        b=1dty3Rzy05ypqnWMHlrLMx4pkgfcoiBJC/0IBCwiGdXroGnMCR+q6/t5UKpQ9S55xA
         PD608qmI7b0PSe59WEbY9Vqcjp6rQVMpKwm/bTolqQXYOn8hPtg6kijo68aumsEDwCy/
         rZGszbJUIHGAWoUj9PqLrjBvhB0aTozHOr8vtvtwRcPPQYanwrbhBSDk+iRkUbUAcmi2
         v2PjmPp3iP/FUVCh3lq/OCwMBy6VQj/W7UBRxbwsEewbnTWN/d90+mWfiEhe92ldyf3N
         kKeqQc4fsYEClB/m2ogErd4IZeaBS9o+fGdnLCPHriVPZ6XUODBapiD/XtvSnFPARQf6
         RxqA==
X-Gm-Message-State: AOAM532+crHkfFf+B9GxZen1cZLEd2LkFh6rYuNgHSLFOissfaHMFYSc
        6Rlw51TJIj/O02rYLTqduyjSPbhOGBJR4w==
X-Google-Smtp-Source: ABdhPJxVEhCEZTJtTSC5zhVEigMGz0yAYVgmOZS7TswXqr4M2vSlUmp0OsX2Km1CTaHIzlt+njWgHw==
X-Received: by 2002:a62:7a8b:0:b0:44d:47e2:99bf with SMTP id v133-20020a627a8b000000b0044d47e299bfmr13538017pfc.64.1634334005122;
        Fri, 15 Oct 2021 14:40:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y3sm5567560pfo.188.2021.10.15.14.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 14:40:04 -0700 (PDT)
Date:   Fri, 15 Oct 2021 14:40:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: The one and only "permission denied" in find /sys
Message-ID: <202110151437.25B5543@keescook>
References: <cd81a57e-e2c1-03c5-d0da-f898babf92e7@landley.net>
 <7042EFC5-DA90-4B9A-951A-036889FD89CA@chromium.org>
 <20211015091447.634toiguzrgyz22j@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211015091447.634toiguzrgyz22j@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 11:14:47AM +0200, Christian Brauner wrote:
> On Wed, Oct 13, 2021 at 06:48:26PM -0700, Kees Cook wrote:
> > 
> > 
> > On October 13, 2021 1:12:16 PM PDT, Rob Landley <rob@landley.net> wrote:
> > >There is exactly one directory in the whole of sysfs that a normal user can't
> > >read (at least on my stock devuan laptop):
> > >
> > >  $ find /sys -name potato
> > >  find: ‘/sys/fs/pstore’: Permission denied
> > >
> > >It's the "pstore" filesystem, it was explicitly broken by commit d7caa33687ce,
> > >and the commit seems to say this was to fix an issue that didn't exist yet but
> > >might someday.
> > 
> > Right, so, the problem did certainly exist: there was a capability check for opening the files, which made it difficult for pstore collector tools to run with sane least privileges. Adjusting the root directory was the simplest way to keep the files secure by default, and allow a system owner the ability to delegate collector permissions to a user or group via just a chmod on the root directory.
> > 
> > >Did whatever issue it was concerned about ever actually start happening? Why did
> > >you not change the permissions on the files _in_ the directory so they weren't
> > >world readable instead? Should /dev/shm stop being world ls-able as well?
> > 
> > Making the per-file permissions configurable at runtime was more complex for little additional gain.
> > 
> > /dev/shm has the benefit of having an existing permission model for each created file.
> > 
> > I wouldn't be opposed to a mount option to specify the default file owner/group, but it makes user space plumbing more difficult (i.e. last I checked, stuff like systemd tends to just mount kernel filesystems without options).
> 
> Hm, no, we do mount kernel filesystems with different options. :)
> So if pstore gains an option that could be changed pretty easily. Unless
> you meant something else by kernel filesystems. :)
> 
> static const MountPoint mount_table[] = {
         ^^^^^

right, I should have been more clear. I haven't seen a way for systemd
users to specify different mount options for "kernel filesystems".

> [...]
>         { "pstore",      "/sys/fs/pstore",            "pstore",     NULL,                                      MS_NOSUID|MS_NOEXEC|MS_NODEV,
>           NULL,          MNT_NONE                   },

If it will do /etc/fstab merging, then sure, I'd be open to taking
patches that would make the file ownership/group be mount-time
configurable.

-- 
Kees Cook
