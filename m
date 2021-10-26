Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0974C43B573
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 17:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhJZP0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 11:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhJZP00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:26:26 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD94C061745;
        Tue, 26 Oct 2021 08:24:02 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h20so10737498ila.4;
        Tue, 26 Oct 2021 08:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYegGVgHZz6GXBZoiZmw9ty75Gg5qvqUFcTPtUsmBxg=;
        b=NumiM/Y/a185fekTBwz7zlsMCVCEHsbSwC6ASEFJPpZwJ9KxnNn7TXPfWlWkpOMi35
         9wcHCTCCon03Oq1aybYyithNFjy9FrJQ1W+WIrMc6MdMXkqYz/NUV/zoT5+umpq6H9W/
         NGbs1pbGfaEl5GunopTbX4C9STNQGNGzE7P6y4OBw5ELP/+BuTZDz8O7EK+sLUSu3pUO
         HvYyf1BjKjwtXkVmuafSqwZA2++qjIiesaFeDAjYUdvktWCtWPCZfCppVQqurZPAj9vb
         n/eVa/852UWLOgqN0yjwlWVX6LR7xbKPzAkV2SSVjemCHfyjGENrfnVYpwqPsrYDMFKa
         mvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYegGVgHZz6GXBZoiZmw9ty75Gg5qvqUFcTPtUsmBxg=;
        b=w1GlL5qEW8MSGWlmYeUXg3iYr9kUGUULrBeEC3FGR+0U6dssILbItXr72e4BawD24y
         +BOXsS4k8SrRQBtWm3yNytcHBN2/5f4/xhRcBmJfj8n7jEbzdDtmSUcVWGyHw8CoiBcE
         BAoQmCvjZxv8WDpQRclP9B7JGuMmSaG2NTF6vLTCQAtUjzbm7rCyIFqPFoxU1Qr6pmKf
         Cnj837AxbEByIl9z0VaERDt76jmLhmtLRmk38cxuIl9Cp93pRyBwg67xKJORc0vtTBvh
         h0/Q4aE55YH5zzHyQYK89H2jcblUh0EItrZYSKYmhhLa2dZCGqMB5VDn7K+o7IUWxm0R
         DV3Q==
X-Gm-Message-State: AOAM532/gAjCtTQaXklPNObNhaYcxN/vq+m4u6fU/hIzGn5PqwyoS9Ju
        93DHrd8nDV1SErNPWNDN2Uhjt4YhkWdOaciBqMxR2KKI2Ug=
X-Google-Smtp-Source: ABdhPJxFPq8W0tpjh0fWgwIQzwEbHX6/p0HBAATLcbPwo7bZWsGjC+PH1oKyROgX+BH9LO9ZeqMDnXOpk04wu/Sd7xU=
X-Received: by 2002:a05:6e02:18cf:: with SMTP id s15mr10296610ilu.198.1635261841745;
 Tue, 26 Oct 2021 08:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211025204634.2517-1-iangelak@redhat.com>
In-Reply-To: <20211025204634.2517-1-iangelak@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Oct 2021 18:23:50 +0300
Message-ID: <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:47 PM Ioannis Angelakopoulos
<iangelak@redhat.com> wrote:
>
> Hello,
>
> I am a PhD student currently interning at Red Hat and working on the
> virtiofs file system. I am trying to add support for the Inotify
> notification subsystem in virtiofs. I seek your feedback and
> suggestions on what is the right direction to take.
>

Hi Ioannis!

I am very happy that you have taken on this task.
People have been requesting this functionality in the past [1]
Not specifically for FUSE, but FUSE is a very good place to start.

[1] https://lore.kernel.org/linux-fsdevel/CAH2r5mt1Fy6hR+Rdig0sHsOS8fVQDsKf9HqZjvjORS3R-7=RFw@mail.gmail.com/

> Currently, virtiofs does not support the Inotify API and there are
> applications which look for the Inotify support in virtiofs (e.g., Kata
> containers).
>
> However, all the event notification subsystems (Dnotify/Inotify/Fanotify)
> are supported by only by local kernel file systems.
>
> --Proposed solution
>
> With this RFC patch we add the inotify support to the FUSE kernel module
> so that the remote virtiofs file system (based on FUSE) used by a QEMU
> guest VM can make use of this feature.
>
> Specifically, we enhance FUSE to add/modify/delete watches on the FUSE
> server and also receive remote inotify events. To achieve this we modify
> the fsnotify subsystem so that it calls specific hooks in FUSE when a
> remote watch is added/modified/deleted and FUSE calls into fsnotify when
> a remote event is received to send the event to user space.
>
> In our case the FUSE server is virtiofsd.
>
> We also considered an out of band approach for implementing the remote
> notifications (e.g., FAM, Gamin), however this approach would break
> applications that are already compatible with inotify, and thus would
> require an update.
>
> These kernel patches depend on the patch series posted by Vivek Goyal:
> https://lore.kernel.org/linux-fsdevel/20210930143850.1188628-1-vgoyal@redhat.com/

It would be a shame if remote fsnotify was not added as a generic
capability to FUSE filesystems and not only virtiofs.
Is there a way to get rid of this dependency?

>
> My PoC Linux kernel patches are here:
> https://github.com/iangelak/linux/commits/inotify_v1
>
> My PoC virtiofsd corresponding patches are here:
> https://github.com/iangelak/qemu/commits/inotify_v1
>
> --Advantages
>
> 1) Our approach is compatible with existing applications that rely on
> Inotify, thus improves portability.
>
> 2) Everything is implemented in one place (virtiofs and virtiofsd) and
> there is no need to run additional processes (daemons) specifically to
> handle the remote notifications.
>
> --Weaknesses
>
> 1) Both a local (QEMU guest) and a remote (Host/Virtiofsd) watch on the
> target inode have to be active at the same time. The local watch
> guarantees that events are going to be sent to the guest user space while
> the remote watch captures events occurring on the host (and will be sent
> to the guest).
>
> As a result, when an event occures on a inode within the exported
> directory by virtiofs, two events will be generated at the same time; a
> local event (generated by the guest kernel) and a remote event (generated
> by the host), thus the guest will receive duplicate events.
>
> To account for this issue we implemented two modes; one where local events
> function as expected (when virtiofsd does not support the remote
> inotify) and one where the local events are suppressed and only the
> remote events originating from the host side are let through (when
> virtiofsd supports the remote inotify).

Dropping events from the local side would be weird.
Avoiding duplicate events is not a good enough reason IMO
compared to the problems this could cause.
I am not convinced this is worth it.

>
> 3) The lifetime of the local watch in the guest kernel is very
> important. Specifically, there is a possibility that the guest does not
> receive remote events on time, if it removes its local watch on the
> target or deletes the inode (and thus the guest kernel removes the watch).
> In these cases the guest kernel removes the local watch before the
> remote events arrive from the host (virtiofsd) and as such the guest
> kernel drops all the remote events for the target inode (since the
> corresponding local watch does not exist anymore). On top of that,
> virtiofsd keeps an open proc file descriptor for each inode that is not
> immediately closed on a inode deletion request by the guest. As a result
> no IN_DELETE_SELF is generated by virtiofsd and sent to the guest kernel
> in this case.
>
> 4) Because virtiofsd implements additional operations during the
> servicing of a request from the guest, additional inotify events might
> be generated and sent to the guest other than the ones the guest
> expects. However, this is not technically a limitation and it is dependent
> on the implementation of the remote file system server (in this case
> virtiofsd).
>
> 5) The current implementation only supports Inotify, due to its
> simplicity and not Fanotify. Fanotify's complexity requires support from
> virtiofsd that is not currently available. One such example is
> Fsnotify's access permission decision capabilities, which could
> conflict with virtiofsd's current access permission implementation.

Good example, bad decision.
It is perfectly fine for a remote server to provide a "supported event mask"
and leave permission events out of the game.

Imagine a remote SMB server, it also does not support all of the events
that the local application would like to set.

That should not be a reason to rule out fanotify, only specific
fanotify events.

Same goes to FAN_MARK_MOUNT and FAN_MARK_FILESYSTEM
remote server may or may not support anything other than watching
inode objects, but it should not be a limit of the "remote fsnotify" API.

Thanks,
Amir.
