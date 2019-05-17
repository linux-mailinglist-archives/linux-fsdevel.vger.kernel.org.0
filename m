Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4FD213F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 09:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfEQHCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 03:02:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42882 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfEQHCA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 03:02:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so5842767wrb.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=Ss4NB5m+SG0EZIQDhH7NjLniRsiUjmxyrNTSlSe9Hss=;
        b=PLgLyLnGuNGgT8VXGDwFxsshlERTrEv9OeoVFs0VRs0YgE+oPWe56SBGIyYtrVf2qT
         h2pdyfEY/oOLqsJF5QN2mBsXJLsqmOkXJo/R6RZYSLOMW/LOsm5w2oJ8lYNTcc3uA17x
         2EV4wPAYG/ukn1NpGIT68nOA5b3i25a7sq3W9IhHEuhpuFTpbQ1AU7cpe8D7hESI6PPv
         lovLb4l0+uh5JFzw3HisD90486y8A6x05kXEZ6ctIlvmi6xE6u0nnGaMk7kNuYD2Eraw
         stZ+ACK2Cb7HA29wckCg26It3pti49UGs62KuUwdrA1d8+FhhFMcUsA+GBaNXrnM83sl
         Igfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Ss4NB5m+SG0EZIQDhH7NjLniRsiUjmxyrNTSlSe9Hss=;
        b=AycRyF/VVYkerHSkUIl1+BkOg4bKgKjmKN5KTry6XccSvAD5ffWmNfsULCpedTZsRJ
         RO6CQtJDzu2Pwku3pkbGTV82nzvPbYGKCEx9fU/yJFip3aWkx3gTtD/0vX+5++FK4Ig+
         v/TBR1EKX0nPpBontf2pPaZLUY6OZI3VmUJ7IQALJLEisZD99xVqO08pl6d2p+b4+zVy
         C1zGcc7NDYJhSw+SDjsFpV2aRlF84C/+GhC9XxXEZug2aVc7GT3wvcfi8Bjn06NSzOxb
         RN1gKe9iv5qdftakbDNlkAO1V3ZdqWUAVbGEpn96sAME/luxmAioxOox3+hYIDLi+X2P
         qw5w==
X-Gm-Message-State: APjAAAXgCipVh5oq23855DUtiNIS2SNq8W+ECuuAWNggMrV2Wtw5nDhp
        YA6DnjXUVcARUCyyo0T0WLqbdw==
X-Google-Smtp-Source: APXvYqwlgwQ3Ti3QErOn6prvvwGIqOr2oU52GGb1WUMpJUlWibmqRpjYkl8UEH1bwumcelp6Jd7x0g==
X-Received: by 2002:adf:f6c4:: with SMTP id y4mr6314398wrp.37.1558076518190;
        Fri, 17 May 2019 00:01:58 -0700 (PDT)
Received: from [172.18.135.95] ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id e8sm16976835wrc.34.2019.05.17.00.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 00:01:57 -0700 (PDT)
Date:   Fri, 17 May 2019 09:01:42 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190516165021.GD17978@ZenIV.linux.org.uk>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk> <20190516162259.GB17978@ZenIV.linux.org.uk> <20190516163151.urrmrueugockxtdy@brauner.io> <20190516165021.GD17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api <linux-api@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <F67AF221-C576-4424-88D7-7C6074D0A6C6@brauner.io>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 16, 2019 6:50:22 PM GMT+02:00, Al Viro <viro@zeniv=2Elinux=2Eorg=2Eu=
k> wrote:
>[linux-abi cc'd]
>
>On Thu, May 16, 2019 at 06:31:52PM +0200, Christian Brauner wrote:
>> On Thu, May 16, 2019 at 05:22:59PM +0100, Al Viro wrote:
>> > On Thu, May 16, 2019 at 12:52:04PM +0100, David Howells wrote:
>> > >=20
>> > > Hi Linus, Al,
>> > >=20
>> > > Here are some patches that make changes to the mount API UAPI and
>two of
>> > > them really need applying, before -rc1 - if they're going to be
>applied at
>> > > all=2E
>> >=20
>> > I'm fine with 2--4, but I'm not convinced that cloexec-by-default
>crusade
>> > makes any sense=2E  Could somebody give coherent arguments in favour
>of
>> > abandoning the existing conventions?
>>=20
>> So as I said in the commit message=2E From a userspace perspective it's
>> more of an issue if one accidently leaks an fd to a task during exec=2E
>>=20
>> Also, most of the time one does not want to inherit an fd during an
>> exec=2E It is a hazzle to always have to specify an extra flag=2E
>>=20
>> As Al pointed out to me open() semantics are not going anywhere=2E
>Sure,
>> no argument there at all=2E
>> But the idea of making fds cloexec by default is only targeted at fds
>> that come from separate syscalls=2E fsopen(), open_tree_clone(), etc=2E
>they
>> all return fds independent of open() so it's really easy to have them
>> cloexec by default without regressing anyone and we also remove the
>need
>> for a bunch of separate flags for each syscall to turn them into
>> cloexec-fds=2E I mean, those for syscalls came with 4 separate flags to
>be
>> able to specify that the returned fd should be made cloexec=2E The
>other
>> way around, cloexec by default, fcntl() to remove the cloexec bit is
>way
>> saner imho=2E
>
>Re separate flags - it is, in principle, a valid argument=2E  OTOH, I'm
>not
>sure if they need to be separate - they all have the same value and
>I don't see any reason for that to change=2E=2E=2E

One last thing I'd like to point out is that
we already have syscalls and ioctls that
return cloexec fds=2E So the consistency
argument is kinda dead=2E

If you still prefer to have cloexec flags
for the 4 new syscalls then yes,
if they could at least all have the same name
(FSMOUNT_CLOEXEC?) that would be good=2E

>
>Only tangentially related, but I wonder if something like
>close_range(from, to)
>would be a more useful approach=2E=2E=2E  That kind of open-coded loops i=
s
>not
>rare in userland and kernel-side code can do them much cheaper=2E=20
>Something
>like
>	/* that exec is sensitive */
>	unshare(CLONE_FILES);
>	/* we don't want anything past stderr here */
>	close_range(3, ~0U);
>	execve(=2E=2E=2E=2E);
>on the userland side of thing=2E  Comments?

Said it before but, the list was mistyped so again:
I think that's a great idea=2E
I have a prototype for close_range(start, end, flags)=2E
I'll wait after rc1 and then send it out=2E

Christian
