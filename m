Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF165E53C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 21:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIUT0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 15:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIUT0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:26:13 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3C592F44
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 12:26:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id z20so8276070ljq.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SB0ZL3ET5KIRiXLzJBPRplLaECUUBPQ/n6fLwa5hHA8=;
        b=0A5e59msr8vZ9yyswtDGOENd9aDNdfqvLUSiJXcQicnCVo7nNeHpFu+d6Ow6+qNhTS
         Y2q5K1hAOfFO8+dpOCigOXgV8M/pbEe3K7y/rzqqGL9LoNChUSrb2pkRahORLufp2uNQ
         9/oUFyzHqOtmTjXzT2Z7oSDKN1xJNpAa0Jddb+aLcNc3tirgXmbXVuyZxc6e131yIVjQ
         hQjxxLXeVO80G3jl+jikLL6WUSmyipysOAZvj17vDHGMjtMHuSwGQCGI3PBFtLO1iMbA
         DCFoh4lvIspc37sZc8KmWtDoE3ohyFq5MLu1QUZTYY3o/XeGP6Hc4ouQGPbnMpjRPjtw
         jLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SB0ZL3ET5KIRiXLzJBPRplLaECUUBPQ/n6fLwa5hHA8=;
        b=qY5pAEj3Mh4s3pPS2SUakY8CTLI74+RNKQOvZBxcJRLGyUYnw+Hv4emdidLY1dq1hH
         r+94oa26oHopK++P7jd3qCAbNWeKNnUvVMZcG8OkUa1N5ZALxcLxAzokydEPXwqnZaYD
         73cn4RYqGJu6lNWaVZI9+li958KXojwS6/Gjz24KCZCy6zrioqa83QhGcFUaYN4YXnPM
         nIU3y6Ro5ho76XD2WvbslDIzslwwIs2WdSyg1KsTW+1YRSw6Uc29cbAskC9cJ+Ev6wEQ
         qYVNK2+6ZGVo07ldH3XdPjiWI2pdC4uI8AsCtKFYRSW8cuzsiYaMfjJ9UkZIf96FJqFb
         cLow==
X-Gm-Message-State: ACrzQf3bPzMXhNNFH9sUamI6/lFHhTQ1+Oz53Odo8Pfp751wRk2xU2MW
        uk8T+7iuh86VUNVk2RoUdSrVpyjSS2rQRmgGTiDGlrqRsBO8+g==
X-Google-Smtp-Source: AMsMyM5KO0UwDQkeO6ykB9BNj9gI3KAjgKqiJnM2Fz59q7a2ZikJNq5vRGZQQczhPRWAQLxQ28aQDNsI3e9uHsuaO08=
X-Received: by 2002:a2e:9b89:0:b0:26a:a004:ac3 with SMTP id
 z9-20020a2e9b89000000b0026aa0040ac3mr8832429lji.104.1663788369753; Wed, 21
 Sep 2022 12:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <YvvBs+7YUcrzwV1a@ZenIV> <CAHk-=wgkNwDikLfEkqLxCWR=pLi1rbPZ5eyE8FbfmXP2=r3qcw@mail.gmail.com>
 <Yvvr447B+mqbZAoe@casper.infradead.org> <dc966283-d0b9-b411-0792-c8553b948c2e@canonical.com>
In-Reply-To: <dc966283-d0b9-b411-0792-c8553b948c2e@canonical.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Wed, 21 Sep 2022 15:25:58 -0400
Message-ID: <CAOg9mSRjo-UZ+3OMVZ4VekwSLzmAe0=+t1kr47K_gFzfp-wUwQ@mail.gmail.com>
Subject: Re: [apparmor] Switching to iterate_shared
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> At least CEPH has active maintainers...

Well that's just mean :-) ...

Anywho...

>> in many cases, the existing iterate() implementation works just fine as iterate_shared().
>> https://lwn.net/Articles/686943/

I changed the orangefs .iterate to .iterate_shared... ls still works,
find still works,
xfstests shows no regressions...

I found and ran my getdents program from back when we were working to
go upstream...
it works the same with .iterate as it does with .iterate_shared...

-Mike

On Thu, Aug 18, 2022 at 12:15 PM John Johansen
<john.johansen@canonical.com> wrote:
>
> On 8/16/22 12:11, Matthew Wilcox wrote:
> > On Tue, Aug 16, 2022 at 11:58:36AM -0700, Linus Torvalds wrote:
> >> That said, our filldir code is still confusing as hell. And I would
> >> really like to see that "shared vs non-shared" iterator thing go away,
> >> with everybody using the shared one - and filesystems that can't deal
> >> with it using their own lock.
> >>
> >> But that's a completely independent wart in our complicated filldir saga.
> >>
> >> But if somebody were to look at that iterate-vs-iterate_shared, that
> >> would be lovely. A quick grep shows that we don't have *that* many of
> >> the non-shared cases left:
> >>
> >>        git grep '\.iterate\>.*='
> >>
> >> seems to imply that converting them to a "use my own load" wouldn't be
> >> _too_ bad.
> >>
> >> And some of them might actually be perfectly ok with the shared
> >> semantics (ie inode->i_rwsem held just for reading) and they just were
> >> never converted originally.
> >
> > What's depressing is that some of these are newly added.  It'd be
> > great if we could attach something _like_ __deprecated to things
> > that checkpatch could pick up on.
> >
> > fs/adfs/dir_f.c:        .iterate        = adfs_f_iterate,
> > fs/adfs/dir_fplus.c:    .iterate        = adfs_fplus_iterate,
> >
> > ADFS is read-only, so must be safe?
> >
> > fs/ceph/dir.c:  .iterate = ceph_readdir,
> > fs/ceph/dir.c:  .iterate = ceph_readdir,
> >
> > At least CEPH has active maintainers, cc'd
> >
> > fs/coda/dir.c:  .iterate        = coda_readdir,
> >
> > Would anyone notice if we broke CODA?  Maintainers cc'd anyway.
> >
> > fs/exfat/dir.c: .iterate        = exfat_iterate,
> >
> > Exfat is a new addition, but has active maintainers.
> >
> > fs/jfs/namei.c: .iterate        = jfs_readdir,
> >
> > Maintainer cc'd
> >
> > fs/ntfs/dir.c:  .iterate        = ntfs_readdir,         /* Read directory contents. */
> >
> > Maybe we can get rid of ntfs soon.
> >
> > fs/ocfs2/file.c:        .iterate        = ocfs2_readdir,
> > fs/ocfs2/file.c:        .iterate        = ocfs2_readdir,
> >
> > maintainers cc'd
> >
> > fs/orangefs/dir.c:      .iterate = orangefs_dir_iterate,
> >
> > New; maintainer cc'd
> >
> > fs/overlayfs/readdir.c: .iterate        = ovl_iterate,
> >
> > Active maintainer, cc'd
> >
> > fs/proc/base.c: .iterate        = proc_##LSM##_attr_dir_iterate, \
> >
> > Hmm.  We need both SMACK and Apparmor to agree to this ... cc's added.
>
> This is fine for AppArmor
>
>
> >
> > fs/vboxsf/dir.c:        .iterate = vboxsf_dir_iterate,
> >
> > Also newly added.  Maintainer cc'd.
> >
>
