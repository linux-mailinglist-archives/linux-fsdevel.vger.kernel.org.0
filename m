Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA263F2764
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 09:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbhHTHPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 03:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhHTHPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 03:15:38 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3D6C061575;
        Fri, 20 Aug 2021 00:15:00 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id f15so8560703ilk.4;
        Fri, 20 Aug 2021 00:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJq0fJObbszgHOmKbaDhSquv53eJeu/zeB0v8+OUq9o=;
        b=qT0Qb0xZGQ6XwYq3z9BUpNaGnkeJMvlKRqDP9ce2ks5V6svoG44Hezgxiv72oJWOcY
         EGBl5o6EiQvsj5zHpnoZVnEfgJwTVm7Kri9buvM8nHKO7adajKYFPMuJeArZhS1Y74dM
         DZ+h5Y2PtaLpER3YkMPn/NniYvBOSesGdeORN7c8Jg5+oSTcNS2vt19nxJjndiAfNsDZ
         4OC2e//pVo1pSjHV7pmD/pc4b8DPiVV1/kVKqrcZ5WNRPaiQLIZTgAFpjM5VtyfQd2Rj
         fRL+ZdobvXCeHjER6lEUgBBAje8k26dTikB7cWWJemYf2zi8SiLh6k6+LV2+WtgwUuxe
         qViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJq0fJObbszgHOmKbaDhSquv53eJeu/zeB0v8+OUq9o=;
        b=mgQaDMW+3b6rJrxJh7+xtjX02QUaeyyx3BT1gTFsQSgggfc4CDjZaNf2FeqbNxzviS
         u5hOq9LkWk1o/x2QHhU5jfb8xKJS5NZHhMxZmynw+t1Ze7+TbUPpOFDC/+/HJ+WuiPxp
         keqTexVTT2v8R2pN8ejWNsJ3RaEnCYrvKcwwW2TN3CrrWxjTyKNZ1P3GSVknOQFFfEG0
         FFkOwBgK2TyDdnG3h8NmPssccQkanQUaXDYam7dyinDhU2/zOFCHTVruWRRvFudNKK/r
         sUb/9uqiv332ZCz0HEThz5cHbeIZe/X2T2CHpJafoAZq9s4Z7tjDpUJPK7KBE8IfU7AX
         ylxA==
X-Gm-Message-State: AOAM531KW/OJP6l93C8BOPyXQ0IdF/2bz6ONhpPhdInw3Cn1wRwnhuEA
        fdFb/odig8fEcnwzSgO+y0Y16kcLgYwcil98n02AX8bwof5zzA==
X-Google-Smtp-Source: ABdhPJxN7Tyh6c2VLlNlWSuZDJoJbRC9+GMXWmAa83LxGI21bM3yGIG+cjWhl2IG2NHYkQ7J4PEOA/nn8Cqawjk9c/I=
X-Received: by 2002:a05:6e02:10d0:: with SMTP id s16mr13051282ilj.275.1629443697607;
 Fri, 20 Aug 2021 00:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com> <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133> <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com> <YRcyqbpVqwwq3P6n@casper.infradead.org>
 <87k0kkxbjn.fsf_-_@disp2133> <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org>
 <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com>
 <a1385746582a675c410aca4eb4947320faec4821.camel@kernel.org>
 <CAHk-=wgD-SNxB=2iCurEoP=RjrciRgLtXZ7R_DejK+mXF2etfg@mail.gmail.com> <CAOQ4uxhwcdH1t3WVBdmeyDmvWkQLCgOAWoVZGoCKChppXBNqNA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhwcdH1t3WVBdmeyDmvWkQLCgOAWoVZGoCKChppXBNqNA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 20 Aug 2021 10:14:46 +0300
Message-ID: <CAOQ4uxiZXwaT9gJJweGx1kXR=y7y+cY5uUUV_CHyEeSJ6vJ0Cg@mail.gmail.com>
Subject: Re: Removing Mandatory Locks
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 9:36 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Aug 19, 2021 at 11:32 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Aug 19, 2021 at 1:18 PM Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > Now that I think about it a little more, I actually did get one
> > > complaint a few years ago:
> > >
> > > Someone had upgraded from an earlier distro that supported the -o mand
> > > mount option to a later one that had disabled it, and they had an (old)
> > > fstab entry that specified it.
> >
> > Hmm. We might be able to turn the "return -EINVAL" into just a warning.
> >
> > Yes, yes, currently if you turn off CONFIG_MANDATORY_FILE_LOCKING, we
> > already do that
> >
> >         VFS: "mand" mount option not supported
> >
> > warning print, but then we fail the mount.
> >
> > If CONFIG_MANDATORY_FILE_LOCKING goes away entirely, it might make
> > sense to turn that warning into something bigger, but then let the
> > mount continue - since now that "mand" flag would be purely a legacy
> > thing.
> >
> > And yes, if we do that, we'd want the warning to be a big ugly thing,
> > just to make people very aware of it happening. Right now it's a
> > one-liner that is easy to miss, and the "oh, the mount failed" is the
> > thing that hopefully informs people about the fact that they need to
> > enable CONFIG_MANDATORY_FILE_LOCKING.
> >
> > The logic being that if you can no longer enable mandatory locking in
> > the kernel, the current hard failure seems overly aggressive (and
> > might cause boot failures and inability to fix/report things when it
> > possibly keeps you from using the system at all).
> >
>
> Allow me to play the devil's advocate here - if fstab has '-o mand' we have
> no way of knowing if any application is relying on '-o mand' and adding
> more !!!!! to the warning is mostly good for clearing our conscious ;-)
>
> Not saying we cannot resort to that and not saying there is an easy
> solution, but there is one more solution to consider - force rdonly mount.
> Yes, it could break some systems and possibly fail boot, but then again
> an ext4 fs can already become rdonly due to errors, so it wouldn't
> be the first time that sysadmins/users run into this behavior.
>

Adding an anecdote - this week I got a report from field support
engineers about failure to assemble a RAID0 array, which led to this
warning that *requires* user intervention, in the worse case for boot
device it requires changing kernel boot params:

md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting
md/raid0: please set raid.default_layout to 1 or 2

c84a1372df92 md/raid0: avoid RAID0 data corruption due to layout confusion.

There is no way I would have gotten this report from the field if a failure
was not involved...

The rdonly mount is only needed to get the attention of support people
to look the the kernel logs and find the warning - at this point, not too
many !!!!! are needed ;-)

So we could make 'mand' an alias to 'ro' and print a warning that says:
"'mand' mount option is deprecated, please fix your init scripts.
For caution, your filesystem was mounted rdonly, feel free to remount
rw and move on..."

Thanks,
Amir.
