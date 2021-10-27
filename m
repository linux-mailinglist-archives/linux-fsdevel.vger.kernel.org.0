Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94743C252
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 07:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbhJ0FtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 01:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhJ0FtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:49:19 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4833CC061570;
        Tue, 26 Oct 2021 22:46:50 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d63so2260226iof.4;
        Tue, 26 Oct 2021 22:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLOEvDKKvdGsG+9+k0UI+CbP/3UBW0GfSqcdC8HXjS0=;
        b=WiqEqsaMYE3vNm/r9L2sPfPtOKjicBq4/gBxPa3GaBz2WbjG70JrZ4I4/8Xl9eVy0o
         vfaubcKnW65/IQIRi8irKa7NokHfORNDF3vTsKshHPvoyHx2oR6a4V1zWdZh2gRt+0AD
         aUm/gxA1AEBOPuuqTQsn665in+949cPbcGChxjqUcC8NbZ2b7W8n9X/7XVXU+fDn85Em
         Wbe2nr0AkmDviQcX0LuTdh6OIMz/0gPnqtQW+OyTRdoQoQGsUu4gozlVmH7pMQFeSrCe
         rANPgwv0KHALlShZMN27AKtJlDKD0X58JCEvEOjIK7amHXErg8UC5SZCkZ+Mn72UDHKu
         9VGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLOEvDKKvdGsG+9+k0UI+CbP/3UBW0GfSqcdC8HXjS0=;
        b=vm0zz4PEaVACWMnw36pP/hr/8DLkmUh150vhucKaIK0akGUPylSazC3DebnQNZ2c9W
         oLD6y9GqIezhNDxfkH470pQ79YbcHuO16u1rRhZ+Lf5TMXCG9s5LVDJbDB1i7ds+K1gS
         Y9gaR1wFjIxjHkpc1haLfZyMaK2TmJU5y3EFwSzLgA4uhrHWCy7uMd1TqrOTnd+xVbH7
         8d916jZGSVKyyyfqiuaoTcXZcqjeztv/vU0dioSpgB45hPMPgSbDMQ/ZvVfgoyVbFA5w
         S8Lf7Wbij88TVyaneWX4xjNLycVkgHDvbERr81ssYQG7U//Z9vv25hELptRo3Bvp0IE2
         EXJw==
X-Gm-Message-State: AOAM53216WIIbk6RD+HhumkpxB3nH4KR78Mfeqdbw8+s4eJQjadj/fTO
        6pTlKoLTTrIT8AbOQTVfStvgm6hkc/boUq57PKUZrmuZq1A=
X-Google-Smtp-Source: ABdhPJxGvMAVtkQ40KDzH+Cl9yuFzTgrqXARbpKx6Dv+ZceOtaIaqFypy9l8aiVCgfPb0xXaGu5BWrtmRcBvFFxvOJw=
X-Received: by 2002:a05:6602:26d2:: with SMTP id g18mr17893740ioo.70.1635313609700;
 Tue, 26 Oct 2021 22:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211025204634.2517-1-iangelak@redhat.com> <20211025204634.2517-2-iangelak@redhat.com>
 <CAOQ4uxinGYb0QtgE8To5wc2iijT9VpTgDiXEp-9YXz=t_6eMbA@mail.gmail.com> <CAO17o20+jiij64y7b3eKoCjG5b_mLZj6o1LSnZ7+8exN3dFYEg@mail.gmail.com>
In-Reply-To: <CAO17o20+jiij64y7b3eKoCjG5b_mLZj6o1LSnZ7+8exN3dFYEg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Oct 2021 08:46:38 +0300
Message-ID: <CAOQ4uxhXZTLe00KxaZebhHKZ_3uz0NA2eqrs0fg5uqLAO+VnvQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] FUSE: Add the fsnotify opcode and in/out structs
 to FUSE
To:     Ioannis Angelakopoulos <iangelak@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> > +       uint64_t mask;
>> > +       uint32_t namelen;
>> > +       uint32_t cookie;
>>
>> I object to persisting with the two-events-joined-by-cookie design.
>> Any new design should include a single event for rename
>> with information about src and dst.
>>
>> I know this is inconvenient, but we are NOT going to create a "remote inotify"
>> interface, we need to create a "remote fsnotify" interface and if server wants
>> to use inotify, it will need to join the disjoined MOVE_FROM/TO event into
>> a single "remote event", that FUSE will use to call fsnotify_move().
>>
> I do not fully understand this. Should we define a new "remote" event
> that corresponds to the merged MOVE_FROM/TO events and send that to the guest instead?

Yes.

First of all, my objection to the old cookie API stems from seeing applications
that do not use it correctly and because I find that it can be hard to use it.

For those reasons, when we extended fanotify to provide "inotify compatible"
semantics, the cookie API was not carried over to fanotify.

You can see an example of "inotify compatible" API in the implementation of
fsnotifywatch [1].

That said, the functionality of joining to/from events is still missing in
fanotify and I have posted several proposals for an API extension that
will solve it using an event that contains information on both src and dst [2].

> If that is the case, wouldn't that require that user space processes be aware of this newly added "remote"
> event?

No, the application will not be aware of the FUSE notify protocol at all.
If application is using inotify, it will get the old from+to+cookie events, but
FUSE server will notify the guest {MOVE, inode, from_path, to_path}
and FUSE client will call fsnotify_mode() or a variant.
Then inotify watchers will get what they are used to and fsnotify watchers
will get whatever information the existing or future API will provide.

To explain this from another perspective, you currently implemented the
virtiofsd watch using inotify, but you should not limit virtiofsd to inotify.
Once you learn the benefits of fanotify, you may consider implementing
the virtiofsd watches using fanotify. It should not matter for the inotify
application in the guest at all.

With the current implementation of watch in virtiofsd using inotify, that
will cause the inconvenience of having to match the from/to events
before reporting the event to guest, but inconvenience for a specific
implementation is not what should be driving the API design.

> Also in the inotify man page there is a limitations case that states that it is possible for one of these events
> to be missing. What should the server do in this case?
>

The protocol should be able to carry src and dst information, but
you could leave src (of moved_to) or dst (of moved_from) empty.
In that case, FUSE client cannot call fsnotify_move() as is, so we
can either change fsnotify_move() or use a variant for reporting remote
rename events.

The extra info for rename events with the FAN_REPORT_TARGET_FID
proposal is also designed to be optional.

Thanks,
Amir.

[1] https://man7.org/linux/man-pages/man1/fsnotifywatch.1.html
[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxjYDDk00VPdWtRB1_tf+gCoPFgSQ9O0p0fGaW_JiFUUKA@mail.gmail.com/
