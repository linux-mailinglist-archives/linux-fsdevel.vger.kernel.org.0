Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0955C959
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbiF1M3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345652AbiF1M3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:29:22 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798862BB01;
        Tue, 28 Jun 2022 05:29:21 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id e7so11803515vsp.13;
        Tue, 28 Jun 2022 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wimQzapjci/tNxsMqKMeMRkF2V9K297VGlo0W1Odw0s=;
        b=oe7PRKI+nQfRiq+ebO3duN2nfZrftuLlTCjr6lgBSjNSQaS8h/+cHLJc+TejnTrwsq
         8+IuZ2Kq8RHtyxHK11Ti1kCjFw5ZIsZMpHLZeZpCuUggAoRe99pLnYVlOp1wkEkttjMD
         xUSsugX5IfO55tkNgQKz+/fio58csK+A9FjJBTDJvgKeoLGtiRyXzcuc0oTfQsFty1C4
         FzwGK12J1XoZfww3GjIYaMqNral9EsLeVXzCIRmD22ck5nwYKQSz/7kfx5/SpYEj99V8
         r+lwb5fR2ikDxoAG4j1u2nvLU7WySbqqjIei+FoYDev3tImvStK4/QJPiAWy2BdcFMPJ
         opFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wimQzapjci/tNxsMqKMeMRkF2V9K297VGlo0W1Odw0s=;
        b=p9igo+rW+6nPCa9F/XS8CRJB/eZuBjgQyYR2K3cka13qOidQohwUWFPt6QkHf3gU0o
         PZM9dxpJT8aUY5ZKEuM7wHFMI7UdrsrvsmI3BGo1U6pBELlE3ftFSnCnapkFuA2x0eNa
         QSy2ozgEm8ScKhXOWlfQmDd43bjWcMoJ68uRYafgvw0CYPsjcO2KTIbNqbQvgm6PeKZ/
         hql7rLQcFSMgFA9xeQgyrsiQZm3cLb+08RSyTOXhEnWVeDrgwwXUCAmu0Bc4JHDPx6eW
         6DjRBc3H2B+WVZh540aQvWx3QehZfX1SxB8fefqAnd1PTtv4kHg+KHvb/puadErLI8CU
         NKPw==
X-Gm-Message-State: AJIora8VDxfGEsbLX5XaEAXGFcPSVMLN2CEarshv1vaTCZJr6pWDiXKT
        Xz59vU+bi/A5hvo4I+hzc0SMZYf7bHcloHToWe8=
X-Google-Smtp-Source: AGRyM1vB3d3ZrWgSprpNG3I5cuSOeNUxmBxLHGr/5XtKkN9fVaBUCWi4tJp+VHZMvI6FTS++Pq+lvWHba4Lsjm/u63E=
X-Received: by 2002:a05:6102:38c7:b0:356:4e2f:ae5b with SMTP id
 k7-20020a05610238c700b003564e2fae5bmr1622701vst.71.1656419360645; Tue, 28 Jun
 2022 05:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220628101413.10432-1-duguoweisz@gmail.com> <20220628104528.no4jarh2ihm5gxau@quack3>
 <20220628104853.c3gcsvabqv2zzckd@wittgenstein> <CAC+1NxtAfbKOcW1hykyygScJgN7DsPKxLeuqNNZXLqekHgsG=Q@mail.gmail.com>
In-Reply-To: <CAC+1NxtAfbKOcW1hykyygScJgN7DsPKxLeuqNNZXLqekHgsG=Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 28 Jun 2022 15:29:08 +0300
Message-ID: <CAOQ4uxgtZDihnydqZ04wjm2XCYjui0nnkO0VGzyq-+ERW20pJw@mail.gmail.com>
Subject: Re: [PATCH 6/6] fanotify: add current_user_instances node
To:     guowei du <duguoweisz@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duguowei <duguowei@xiaomi.com>
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

On Tue, Jun 28, 2022 at 2:50 PM guowei du <duguoweisz@gmail.com> wrote:
>
> hi, Mr Kara, Mr Brauner,
>
> I want to know how many fanotify readers are monitoring the fs event.
> If userspace daemons monitoring all file system events are too many, maybe there will be an impact on performance.
>

I want something else which is more than just the number of groups.

I want to provide the admin the option to enumerate over all groups and
list their marks and blocked events.

This would be similar to listing all the fdinfo of anon_inode:[fanotify] fds
of processes that initialised fanotify groups.

This enumeration could be done for example in /sys/fs/fanotify/groups/

My main incentive is not only the enumeration.
My main incentive is to provide an administrative interface to
check for any fs operations that are currently blocked by a rogue
fanotify permission events reader and an easy way for administrators
to kill those rogue processes (i.e. buggy anti-malware).

This interface is inspired by the ability to enumerate and abort
fuse connections for rogue fuse servers.

I want to do that for the existing permission events as a prerequisite
to adding new blocking events to be used for implementation of
hierarchical storage managers, similar the Windows ProjFs [1].
This was allegedly the intended use case for group class
FAN_CLASS_PRE_CONTENT (see man page).

Do you want to implement the first step of enumerating fdinfo
of all groups via /sys/fs/fanotify/groups/?

Jan,

If you have objections to any of the ideas above please shout.
I was going to prepare a roadmap for blocking events and post it
for comments, but this patch triggered a heads up.

Thanks,
Amir.

[1] https://docs.microsoft.com/en-us/windows/win32/projfs/projected-file-system
