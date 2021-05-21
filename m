Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D9438C1D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 10:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhEUIcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 04:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhEUIct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 04:32:49 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FA8C061574;
        Fri, 21 May 2021 01:31:26 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l15so12394894iln.8;
        Fri, 21 May 2021 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fD9naAkCO+UNu0R3N+jM35YfoYNYpu0KqAg9BLMmvKk=;
        b=fq9WeXgEFKy8hMmc48lx06StsL6dK/9jTywTBBfxipX1KnaP2QezFCtpNAFlnadYD0
         xl1X70mRKWRYerFlTvJDzNzhrtTO5cQqkmmeJYgFuYV+Gd2rrQTw1fIxth2bbCliOXNE
         a3Dhq9DpWwqvqbvHkQqsH3H8a2f8hEWo2AUxJBcStUQP2dW4hgp+/FwAGtlW1VaN0GSF
         1iEFtufDFiJcS+coi9P2PxoMXbapf61dzDlkAXOhxEjnVHxyMa60Jg+qh/c+UUhfM2P1
         ppjJvtk1azW99JyH522e93HyDccuhXPweAS3gf4fzUgGksjYWKMzkq8Ts3UNosIyrDFF
         lcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fD9naAkCO+UNu0R3N+jM35YfoYNYpu0KqAg9BLMmvKk=;
        b=frpRChaezLe3fRuewpJnv/4wdagbX9oUhvw8D/ywM3kErWQcw0SratGm4SNIQ3s/Nk
         GfAost8UMWdYWm70kGGNbA85Jpfwo5KQ2TqBehwNY3CdQFdAZHXgR4b9VsV6/4xdRIXZ
         HHaju42TLd6QIlcb/queZti7d5rzzfjQVl6Qu0Phgw0JlW73u99fbB+U3w3VxCucMPKn
         kZk7CLdiSjSLT39jMO3kw31Gku92btMuX5C+JSSdrzO4V4wwCtENfy35Q2B4EL1vbxu4
         +o7hge5cWyQXGeMxzo9rGBpZvLbtd95Q4dq5/G9vZamhgw1mUgfNpEIaCeP4tXBDqzy1
         STNw==
X-Gm-Message-State: AOAM532t12SM3HiLiOZ/E8IWPPYhnNyOse14cFLRI4oiKsM57+kuRRKQ
        SRwNbuTaqoigEBXVkyalGHuFIpbOREp5v+Vic38=
X-Google-Smtp-Source: ABdhPJzNgYFwclIHnCNKcRKMeZoZEgqly+y1H3n9eaINffPodzy6KQWzRZPqcw0lCocmWVKSRBjSGn4LpPf0pOcFHp0=
X-Received: by 2002:a92:4446:: with SMTP id a6mr11074188ilm.9.1621585886178;
 Fri, 21 May 2021 01:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024134.1032503-1-krisman@collabora.com>
In-Reply-To: <20210521024134.1032503-1-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 11:31:15 +0300
Message-ID: <CAOQ4uxjzoRLPK0w=wxpObu5Bg3aV=0+BDEFwhMx5uN5Zx9J5nQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] File system wide monitoring
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 5:42 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> This series follow up on my previous proposal [1] to support file system
> wide monitoring.  As suggested by Amir, this proposal drops the ring
> buffer in favor of a single slot associated with each mark.  This
> simplifies a bit the implementation, as you can see in the code.
>
> As a reminder, This proposal is limited to an interface for
> administrators to monitor the health of a file system, instead of a
> generic inteface for file errors.  Therefore, this doesn't solve the
> problem of writeback errors or the need to watch a specific subtree.
>
> In comparison to the previous RFC, this implementation also drops the
> per-fs data and location, and leave those as future extensions.
>
> * Implementation
>
> The feature is implemented on top of fanotify, as a new type of fanotify
> mark, FAN_ERROR, which a file system monitoring tool can register to
> receive error notifications.  When an error occurs a new notification is
> generated, in addition followed by this info field:
>
>  - FS generic data: A file system agnostic structure that has a generic
>  error code and identifies the filesystem.  Basically, it let's
>  userspace know something happened on a monitored filesystem.  Since
>  only the first error is recorded since the last read, this also
>  includes a counter of errors that happened since the last read.
>
> * Testing
>
> This was tested by watching notifications flowing from an intentionally
> corrupted filesystem in different places.  In addition, other events
> were watched in an attempt to detect regressions.
>
> Is there a specific testsuite for fanotify I should be running?

LTP is where we maintain the fsnotify regression test.
The inotify* and fanotify* tests specifically.

>
> * Patches
>
> This patchset is divided as follows: Patch 1 through 5 are refactoring
> to fsnotify/fanotify in preparation for FS_ERROR/FAN_ERROR; patch 6 and
> 7 implement the FS_ERROR API for filesystems to report error; patch 8
> add support for FAN_ERROR in fanotify; Patch 9 is an example
> implementation for ext4; patch 10 and 11 provide a sample userspace code
> and documentation.
>
> I also pushed the full series to:
>
>   https://gitlab.collabora.com/krisman/linux -b fanotify-notifications-single-slot

All in all the series looks good, give or take some implementation
details.

One general comment about UAPI (CC linux-api) -
I think Darrick has proposed to report ino/gen instead of only ino.
I personally think it would be a shame not to reuse the already existing
FAN_EVENT_INFO_TYPE_FID record format, but I can understand why
you did not want to go there:
1. Not all error reports carry inode information
2. Not all filesystems support file handles
3. Any other reason that I missed?

My proposal is that in cases where group was initialized with
FAN_REPORT_FID (implies fs supports file handles) AND error report
does carry inode information, record fanotify_info in fanotify_error_event
and report FAN_EVENT_INFO_TYPE_FID record in addition to
FAN_EVENT_INFO_TYPE_ERROR record to user.

I am not insisting on this change, but I think it won't add much complexity
to your implementation and it will allow more flexibility to the API going
forward.

However, for the time being, if you want to avoid the UAPI discussion,
I don't mind if you disallow FAN_ERROR mark for group with
FAN_REPORT_FID.

In most likelihood, the tool monitoring filesystem for errors will not care
about other events, so it shouldn't care about FAN_REPORT_FID anyway.
I'd like to hear what other think about this point as well.

Thanks,
Amir.
