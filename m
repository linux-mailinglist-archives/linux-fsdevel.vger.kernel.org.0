Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACB8183853
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 19:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCLSPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 14:15:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46966 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCLSPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:15:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id d23so7518735ljg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQ3QfTDDyb5UoBIAiFsjVBE1W68/HsNyhrkWTB/fuO8=;
        b=MXoIPfUgy938dwO+4Ke7cFDpDrSyBbOMidOjN6VWqwOeAMyfFqF2Y4Ay/rwdS0BizU
         Kppg6HhZcnXQd15+19gbWj60YmAsYBKe5dgNHxhDdmce+HxBvnO/FxXNECxZgBF0nuD7
         +Ow57KwOsRb33vqxZnMj9GjOtkrhmMbMIdqZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQ3QfTDDyb5UoBIAiFsjVBE1W68/HsNyhrkWTB/fuO8=;
        b=Vr2FJb+1rXUGv7sMOK5qk8UEDNYrBOskqklA9aEPkQuxTXBZT/NIG1fbBjQ7t3YxKc
         mDTtYm/jAOixitwe5ozxXS+wdwVpBjsn4ni5I4gVSAJojgFBKwIrYxIjB39+DTmDWsUR
         iy+ecpaE3dowJx76UTwrW+DcdXOJA5PJ2eNKoVfPnriVHtk40F2rOrkJcqbNsLVjK9Dt
         wvFrdN73sjQZDNmb4LL961Ss9gHYAFDQ8jrMpSZkkyQeeBduxescmiEUui9UO+GzC61J
         GK+dI5J3IxteiOkKH27IE34nJ7NdZ/lF+fs5gPcXy40/jmmvG8FcaaNyO0DUlVfKpZhj
         Efww==
X-Gm-Message-State: ANhLgQ1QxKfuzlZKIwKAXtueLdl2Z9CjYet1ODyQmmmgphLB6z0bJ7b8
        cAAdxn142hpepy8Vqt36tFqg5TPbQpM=
X-Google-Smtp-Source: ADFU+vslqpu5BQIiHGuTRfit2CNtlbG7du8nw7237qyK47aIqWh+/im2slNOa0tNKqht3Xr1iZDF1Q==
X-Received: by 2002:a2e:a312:: with SMTP id l18mr5945769lje.229.1584036929402;
        Thu, 12 Mar 2020 11:15:29 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id y24sm32895866lfg.63.2020.03.12.11.15.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 11:15:29 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id u12so7599859ljo.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 11:15:28 -0700 (PDT)
X-Received: by 2002:a05:651c:230:: with SMTP id z16mr5976976ljn.201.1584036591344;
 Thu, 12 Mar 2020 11:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin> <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk> <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org> <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <1147628.1584032201@warthog.procyon.org.uk>
In-Reply-To: <1147628.1584032201@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Mar 2020 11:09:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXg8jpRHd-Dmis7a79fzkuFJwF0Le6WSG=M13=bTxYxQ@mail.gmail.com>
Message-ID: <CAHk-=wjXg8jpRHd-Dmis7a79fzkuFJwF0Le6WSG=M13=bTxYxQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
To:     David Howells <dhowells@redhat.com>
Cc:     Stefan Metzmacher <metze@samba.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
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

On Thu, Mar 12, 2020 at 9:56 AM David Howells <dhowells@redhat.com> wrote:
>
> Any thoughts on which set of flags should override the other?

Do we need to care? I don't think we actually have conflicts, because
the semantics aren't the same, and they are about independent issues.

>                  If we're making
> RESOLVE_* flags the new definitive interface, then I feel they should probably
> override the AT_* flags where there's a conflict, ie. RESOLVE_NO_SYMLINKS
> should override AT_SYMLINK_FOLLOW for example.

That's just for a linkat2() system call? I think the natural semantic
is the one that falls out directly: RESOLVE_NO_SYMLINKS will cause it
to fail with -ELOOP if it is a symlink.

NOTE! This isn't really a "conflict". It's actually two different and
independent things:

 - without AT_SYMLINK_FOLLOW, a linkat() simply won't even try to
follow the symlink, and will link to the symlink itself instead.

 - RESOLVE_NO_SYMLINKS says "never follow symlinks".

Note how one does *NOT* override the other, quite the reverse. They
are about different things. One is about the _behavior_ when the last
component is a symlink, and the other is about permission to follow
any symlinks.

So all combinations make sense:

 - no AT_SYMLINK_FOLLOW, no RESOLVE_NO_SYMLINKS: just link to the
target, whether it's a symlink or not

   This is obviously our historical link() behavior.

 - no AT_SYMLINK_FOLLOW, yes RESOLVE_NO_SYMLINKS: just link to the
target, whether it's a symlink or not, but if there's a symlink in the
middle, return -ELOOP

   Note how this case doesn't follow the last one, so
RESOLVE_NO_SYMLINKS isn't an issue for the last component, but _is_ an
issue for the components in the middle.

 - AT_SYMLINK_FOLLOW, no RESOLVE_NO_SYMLINKS: just link to the target,
following the symlink if it exists

   This is obviously the historical AT_SYMLINK_FOLLOW behavior

 - AT_SYMLINK_FOLLOW | RESOLVE_NO_SYMLINKS: just link to the target,
return -ELOOP if it's a symlink (of if there's a symlink on the way).

   This is the natural behavior for "refuse to follow any symlinks anywhere".

note how they are all completely sane versions, and in no case does
one flag really override the other.

If anything, we actually miss a third flag: the "don't allow linking
to a final symlink at all" (but allow intermediate symlinks). We've
never had that behavior, although I think POSIX makes that case
undefined (ie you're not guaranteed to be able to link to a symlink in
the first place in POSIX).

I guess that third case could be emulated with open(O_PATH) + fstat to
check it's not a symlink + linkat(fd,AT_EMPTY_PATH) if it turns
somebody would want something like that (and we decided that
AT_EMPTY_PATH is ok for linkat()).

I doubt anybody cares.

                 Linus
