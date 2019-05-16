Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8620D97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfEPRBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 13:01:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35531 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEPRBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 13:01:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id g5so1931857plt.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=UbW9OcHTdmweEe6jEqXt1jRPoIseo4HiLO48u7I/E6w=;
        b=bTgD2EPwBGcpZl92sfVXF1mzeT293eUcgXDX1177GZ+Q2351otKnS+/h07ZitT4sQB
         7zP91kzhVMiWU7paAkMJJVxM3b/x1IdEQCoMrH8sbohS31cLXtVHKNMFzJ+0d1htCdOZ
         ZDo43zIWPqLEIi85KM6bgbe+nZl1TfRufuYhy5dnO1eCQhMVSj/QpE4eIFCUfwL0FoFN
         OEY6XQtIUXkfoUVjxHLMfJ8kp9AMqobu1d7H2X4kUB+OEXi9DnnUQY5bnLJonOfnGcLm
         qXJVhKpyujfMt2KLizaodabJUSqlmuiNskVJNHCBWMXq2o/nEedH2d37szJWncf5oteS
         YLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=UbW9OcHTdmweEe6jEqXt1jRPoIseo4HiLO48u7I/E6w=;
        b=Z3LTVjcbkxbZ+KSgXSXY8hE6RFd2WR/lcslDOmTzTLpLuwKvrQGzHlIgkA+TzI06oG
         thkl/4QlVjytbaWExShM1cANtZYYabSFjAyuD/tWqR9yTAkv8OaL+f2UUotkNGCumC6Q
         JUNKHNH1GPnpf3rrBJvYrEbOaMD5HXytX6ExwoRSNn3SpGV8H6MirmmIce8IYqYMD4qQ
         BpuZSa/iwbP8EtOir9sB9v95dzBBMijS9iJ60LkdjiBe/paiu9wa9idJ75Dop36TYYTS
         voL0VNwurx3lndaLvjHz94OrrkUQ9Pecl1ew4n4cSqGGH4ZFglhu3CfoDKD/JgSF9Bdb
         xN3Q==
X-Gm-Message-State: APjAAAWOjtn5yrzlkeIzx2OHFZI/j+fpw3/ciGPQIkzDQrU50hy83HDr
        VMIBkdnQBab8OEszh0ajfs/PNg==
X-Google-Smtp-Source: APXvYqyJy18chfw6Qdjoi4ZIKROBk69gIGm7+7Q5FYxXqcrl/KLsacNX0tJWoYudaBwoVkgxqL/RGw==
X-Received: by 2002:a17:902:b18c:: with SMTP id s12mr32892833plr.181.1558026104675;
        Thu, 16 May 2019 10:01:44 -0700 (PDT)
Received: from [25.170.25.245] ([208.54.39.147])
        by smtp.gmail.com with ESMTPSA id c129sm7997133pfg.178.2019.05.16.10.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 10:01:43 -0700 (PDT)
Date:   Thu, 16 May 2019 19:01:34 +0200
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
        linux-kernel@vger.kernel.org, linux-abi@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <308AC02E-168C-4547-AF64-F98970B4368D@brauner.io>
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

Very much in favor of that!
That'd be a neat new addition=2E
