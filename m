Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8FA6A260C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 01:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBYA7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 19:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBYA7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:59:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC90B15171
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 16:59:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e9so1261338plh.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 16:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S9aocAMEr+7GkgW3HU7yVDSBGR+u57NYWMwUJRKo2Bk=;
        b=od8U79mkMwitVexYUt4QQ5tlzFZdQ8rPbIE4R6jJLGaUjLkZjcbBCqyrQaPALxra5F
         Z3kEU7zJkxtydF4czC7g55QftE2FLFd0sYB5OsMdPsVcgvnOjgbr7H0ei830UCHkBQBp
         boQ68aHZ/rtJui0rsig5qau6uUWb1OnqLqMCcTSGdhmhRnDy1YfokVbxS7hbKcy07KZU
         5Sx/1+JMBH4P1lxYng/cy3XZVWwFXiZeSbozmc1AnOV+1ckZpnGpRvPWfv1PTb8gRxD1
         +R/5I52UxafZAuRafQympiTf84NXcRE/bYsxuVt6dZxHGfrc/ZIsPlH/VJ6V3ceEsHRK
         tUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9aocAMEr+7GkgW3HU7yVDSBGR+u57NYWMwUJRKo2Bk=;
        b=Cf9KTTPZ5Mn00nMtVSqC79pPke88XIIbZ71FNY7dqcYg8D/wPhKN6HoVaNOaVER9so
         Ymn/Wd6aT1vQDBgZ+c6zcUG6RTBu59ASmOAF3kj+VlcUXHRUC3TC03sFi6STg0XAwlNv
         sMtrWkj1iLOP39/VzXym3kaoJc9Kq1unt/LGL+bSmTTUulnLijhh7apf15tbxHQl8z9Y
         0w/SvWcshCw6HWO4yp9lRGw+y8YdSNdgj/HbiNyEIhKek7KxLEMCbev/gtBuv/o5rxtz
         ysY6j2gRR5vdrdGDx83T0CcPCthhu/ZFSlUIxRguYy6FO4XB8bdvk3O41PBSo9Et6x83
         K7PA==
X-Gm-Message-State: AO0yUKXTmErSfxjH4mPHNr9fkkxRpob2Ur5bF+oMk9ToPw3Dtbfx52YW
        SRmBqw2t0mHOEWM9xKjEt1tkDE0Rp5vmxwiofSl2Zg==
X-Google-Smtp-Source: AK7set9dpRGCR6nGdmf4X2bXfCtlIZCSmzj5Vb9/Ky6IvsypRYk9nDg7I71YdrX3ubadlJ4OilYonHu+fNTKxE/GN8E=
X-Received: by 2002:a17:902:f686:b0:198:adbc:9b1e with SMTP id
 l6-20020a170902f68600b00198adbc9b1emr819294plg.5.1677286752903; Fri, 24 Feb
 2023 16:59:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJfpegu6xqH3U1icRcY1SeyVh0h-CirXJ-oaCXUsLCZGQgExUQ@mail.gmail.com>
In-Reply-To: <CAJfpegu6xqH3U1icRcY1SeyVh0h-CirXJ-oaCXUsLCZGQgExUQ@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Fri, 24 Feb 2023 16:59:01 -0800
Message-ID: <CA+PiJmRYG=KOhjw5M+JBKHEEN1XfE2fYQhn+3NDLr_Gw3yBozA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] fuse passthrough solutions and status
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Alessio Balsini <balsini@android.com>,
        bpf <bpf@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 10, 2023 at 7:52 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Several fuse based filesystems pass file data from an underlying
> filesystem without modification.  The added value can come from
> changed directory structure, changed metadata or the ability to
> intercept I/O only in special cases.  This pattern is very common, so
> optimizing it could be very worthwhile.
>
> I'd like to discuss proposed solutions to enabling data passthrough.
> There are several prototypes:
>
>  - fuse2[1] (myself, very old)
>  - fuse-passthrough[2] (Alessio Balsini, more recent)
>  - fuse-bpf[3] (Daniel Rosenberg, new)
>
> The scope of fuse-bpf is much wider, but it does offer conditional
> passthrough behavior as well.
>
> One of the questions is how to reference underlying files.  Passing
> open file descriptors directly in the fuse messages could be
> dangerous[4].  Setting up the mapping from an open file descriptor to
> the kernel using an ioctl() instead should be safe.
>
> Other open issues:
>
>  - what shall be the lifetime of the mapping?
>
>  - does the mapped open file need to be visible to userspace?
> Remember, this is a kernel module, so there's no process involved
> where you could look at /proc/PID/fd.  Adding a kernel thread for each
> fuse instance that installs these mapped fds as actual file descriptor
> might be the solution.
>
> Thanks,
> Miklos
>
>
> [1] https://lore.kernel.org/all/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2oQiOZXVB1+7g@mail.gmail.com/
>
> [2] https://lore.kernel.org/all/20210125153057.3623715-1-balsini@android.com/
>
> [3] https://lore.kernel.org/all/20221122021536.1629178-1-drosen@google.com/
>
> [4] https://lore.kernel.org/all/CAG48ez17uXtjCTa7xpa=JWz3iBbNDQTKO2hvn6PAZtfW3kXgcA@mail.gmail.com/

I'd be very interested to discuss fuse-bpf, and how it aligns with the
other efforts. I recall there being some io uring effort as well,
though I haven't looked into that too much yet.

Currently there are plenty of open areas for discussion with how the
bpf side of fuse-bpf interacts with the userspace daemon, particularly
if you create a node via bpf, and later want to handle some call for
it via the daemon.

I've been working on switching fuse-bpf over to using bpf's struct_ops
and kfuncs, along with dynptrs which open up a lot more opportunities
for adding capabilities on the bpf side. For the file descriptor
passing, I'm currently using an ioctl that acts as a mirror of the
/dev node. Normal fuse responses to lookup that add a backing file are
rejected unless they take the ioctl path.

-Daniel
