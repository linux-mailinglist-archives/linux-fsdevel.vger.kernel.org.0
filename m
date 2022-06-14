Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB8254BBB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357667AbiFNUYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 16:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbiFNUYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:24:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC4F3ED2E
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 13:24:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q11so10610524iod.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vaTd6J5QW2zH+C0RW1NLJUMn73O3x7V9fILF9tLqrzI=;
        b=gRVRxHZMe7GB0CMT7h68KGoW9wprnOjEoeTrdTux4jLVQBc6iVdCNm+kcl5WQF+Cz2
         JtExKCFNoo4EFeNNqD1eSojr64JLEV1BfzRV+EQZHSvC5LBywUXaf7kQiiOO235C86X4
         hNYJtch2R0PBiluBbXbdWKTzekpDDqXVBeRFj5DN1+VkM13YIRCzp3WG7Km0S+mA0uLj
         vrnR7unp0020iNc1qX1iTREpmwCXBKBpqjTpoKG3ANGjME/Yv9bcclsdEN26n4G6qFA3
         ac8RReknpeEI4OpUlVPxbdvgkyf0lalZQJIWbI5ZeHntnojVYz6B+Tiiecxqlao2LfIH
         17Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vaTd6J5QW2zH+C0RW1NLJUMn73O3x7V9fILF9tLqrzI=;
        b=vs8jl7cMjIBEV3GKYvA8zpAMbTfC3bSEVWsR0ggXE0cXBqBy8eXcEdCZEehTO629pk
         fpqfL6egjAPqO2/TUQU2avFpY9qe5Ma5d73o5ZoKwJIkNXSJYUXKPEzyN1aJIBC2Exlr
         +A0+Y6E8xCkLd84H2nmVnEGGriUSsjNiw2x5EjYEa9NoGpLFIFmYBDNKa4dfdmRyDTYw
         ikLkIBUvl5R0z+5Hw3KL5AnjWkeFk1ABNIENErPzOAWbWcCeq4MtMLoKzejrTyv78bkA
         OI3qswLlFVfgvBsgpw7pmOsFr2K/cs+2mTp4of1/XhHLaZxpx59CWWX3mmKC77Q/i8JU
         WREw==
X-Gm-Message-State: AOAM531TQWYOHFawsEZDK+Xr1iqY+K9Vu2Tf+opnOLVv0Gu7GBEjlzbU
        HI+B1DAwBhn6SAp+zqEAXY75tElXKVBuXPvKVBChrw==
X-Google-Smtp-Source: ABdhPJxLjAfk4yJjPZ49rC5OWFXh9ANQ837dlv+XDuJcCGSbPEAHdRsUXzEvf2lpgiu8Gw11a3UVil6vMRe/1LGT4wQ=
X-Received: by 2002:a6b:3e42:0:b0:669:ae49:589 with SMTP id
 l63-20020a6b3e42000000b00669ae490589mr3353488ioa.138.1655238268174; Tue, 14
 Jun 2022 13:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-3-axelrasmussen@google.com> <20220613145540.1c9f7750092911bae1332b92@linux-foundation.org>
 <Yqe6R+XSH+nFc8se@xz-m1.local> <CAJHvVchdmV42qCgO6j=zGBi0DeVcvW1OC88rHUP6V66Fg3CSww@mail.gmail.com>
 <87k09kxi59.fsf@meer.lwn.net>
In-Reply-To: <87k09kxi59.fsf@meer.lwn.net>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 14 Jun 2022 13:23:52 -0700
Message-ID: <CAJHvVcjAnewRATU3AAZK+TFpNbfiVATfd1tt_ok2k+X+3s3dBA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 4:23 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Axel Rasmussen <axelrasmussen@google.com> writes:
>
> > I think for any approach involving syscalls, we need to be able to
> > control access to who can call a syscall. Maybe there's another way
> > I'm not aware of, but I think today the only mechanism to do this is
> > capabilities. I proposed adding a CAP_USERFAULTFD for this purpose,
> > but that approach was rejected [1]. So, I'm not sure of another way
> > besides using a device node.
>
> I take it there's a reason why this can't be done with a security module
> - either a custom module or a policy in one of the existing modules?
> That sort of access control is just what security modules are supposed
> to be for, after all.
>
> Thanks,
>
> jon

Admittedly I haven't tried proposing a patch, but I suspect there
would be pushback against adding an entirely new LSM just for this
case, similarly to the reasons the CAP_USERFAULTFD approach was
rejected.

For existing LSMs, I think SELinux can be used to restrict access to
syscalls. But then again, it's fairly heavy weight / difficult to
configure, and I suspect migrating production servers which don't use
it today would be a nontrivial undertaking. At least to me it seems
unfortunate to say, there isn't an obvious "safe" way to use
userfaultfd, without enabling + configuring selinux. (That assumes by
"safe" we mean, without granting wider-than necessary access to
userfaultfd, or without granting uffd-using processes more permissions
[root or CAP_SYS_PTRACE] to do their job.) I suspect if we do that
then in practice many? most? users will just either run UFFD programs
as root, or toggle the sysctl to allow unprivileged UFFD usage.
