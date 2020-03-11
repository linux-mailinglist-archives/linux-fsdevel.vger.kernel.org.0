Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7619B182037
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 19:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgCKSAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 14:00:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44687 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbgCKSAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:00:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id b186so2410172lfg.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpqDD1Wo+HKU40oDoKA/BJI8LsaHpPP8z3qrK9mKasM=;
        b=ckkZBdQmXywHGIbczwxKoXJtM5bn1Q4zF8980dmDzUAerY42Vnt79h0/hrgko+maFY
         g6W5qtOcDU0FR7TReGj9YV2UAWuNcF/lAEUT03GfvSsuEW22s7MzLhczmTz71ew7VoeG
         9tipLpaaHNIEBXH+b/EPSFlrBcI9QWo4iyKEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpqDD1Wo+HKU40oDoKA/BJI8LsaHpPP8z3qrK9mKasM=;
        b=rxfk9oe5G6gYgNvFj1Enig/PmX2YbJkzrKwKMmy3aoYX0SssfXSWFCdPFTEKaqmXrv
         OjFCoshll2qaiRAdRaGI4IBdcpwsqD0nrlFrW3I3SEBQJ4zqVhT8LtKUemCbyf1ESveW
         nt8oA+Y1ajU9HR85NNN7znRLmNIqL3ozKmnYqulBDI/yDa0jbV5PxW/2po4Z8j6838IP
         zsR+k+SGIWf0T6wdhp8qC1zW5ViWQvzH8fLEBNah3sTLYy7d8HxPxTeaCyll6LW29jhY
         NtuD274TFLkR+pRMaQ75bcccKz1d8vbLS86Ax4qqW3PiqHpP+gbqfhuaTYKd3gblQI/l
         Fsjg==
X-Gm-Message-State: ANhLgQ3QebjRfScxsTRYavW6hjAW79+W+z55iaUu/MMwHzqfQWgX0IjX
        8E4o/fWr55xJs1R3EdS4JONR5oPgfLk=
X-Google-Smtp-Source: ADFU+vsql6gat8Hmi8gW8F3CUXliw14NUIj22VA8BFmZkpg/r4uehrnYwv4xztThvtUTnVItdTO1CQ==
X-Received: by 2002:ac2:5473:: with SMTP id e19mr2830081lfn.24.1583949608170;
        Wed, 11 Mar 2020 11:00:08 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x11sm23774903ljj.47.2020.03.11.11.00.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:00:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id o10so3351631ljc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 11:00:07 -0700 (PDT)
X-Received: by 2002:a2e:5850:: with SMTP id x16mr2622296ljd.209.1583949607115;
 Wed, 11 Mar 2020 11:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin> <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
In-Reply-To: <580352.1583825105@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 10:59:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
Message-ID: <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     David Howells <dhowells@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Metzmacher <metze@samba.org>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:25 AM David Howells <dhowells@redhat.com> wrote:
?
> Okay.  So what's the equivalent of AT_SYMLINK_NOFOLLOW in RESOLVE_* flag
> terms?

Nothing.

openat2() takes two sets of flags. We'll never get rid of
AT_SYMLINK_NOFOLLOW / O_NOFOLLOW, and we've added RESOLVE_NO_SYMLINKS
to the new set of flags. It's just a separate namespace.

We will _not_ be adding a RESOLVE_XYZ flag for O_NOFOLLOW or
AT_SYMLINK_NOFOLLOW. At least not visible to user space - because as
people already figured out, that just causes problems with consistency
issues.

And yes, the fact that we then have three different user-visible
namespaces (O_xyz flags for open(), AT_xyz flags for linkat(), and now
RESOLVE_xyz flags for openat2()) is sad and messy. But it's an
inherent messiness from just how the world works. We can't get rid of
it.

If we need linkat2() and friends, so be it. Do we?

Could we have a _fourth_ set of flags that are simply for internal use
that is a superset of them all? Sure. But no, it's almost certainly
not worth it. Four is not better than three.

Now, some type-safety in the kernel to make sure that we can't mix
AT_xyz with O_xyz or RESOLVE_xyz - that might be worth it. Although
judging by past experience, not enough people run sparse for it to
really be worth it.

               Linus

PS. Yeah, we also have that LOOKUP_xyz namespace, and the access mode
namespace, so we already have those internal format versions too.
