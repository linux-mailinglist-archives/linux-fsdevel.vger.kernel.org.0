Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84393F34CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 21:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhHTTt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 15:49:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55879 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhHTTt1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:49:27 -0400
X-Greylist: delayed 1672 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Aug 2021 15:49:27 EDT
Received: from [IPv6:::1] ([IPv6:2601:646:8600:3c71:6111:82d6:dfad:778c])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 17KJHuYd937846
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 20 Aug 2021 12:17:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 17KJHuYd937846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021073001; t=1629487085;
        bh=Swjddd6h78nIFLV61ZIUR3LeMVGCy8t3nFizFuvLjOo=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=KscL6G2l89RQDkEtrhzSWjkvZrFHDi+mzgdzo/IbbPwLq6hNBd/OSU8dL1PWFV2XB
         wW+VbG4+sezrIAFCFB8T+pmg6Yfqoj7N7eBkkAi2dUC3C8vdIwop4fIXcbDs3wMfpG
         f0B3USGu38WtkjiXeVwFomXyjKRnp5IO2zD5dCWSTRgpWS1BQ7x4EK1amPlOfx2g2R
         39Seo/9NcBLHhjPLJQzAbvNgCgsmAdvLK7fdWXaH+KOi+8B2NwpUmMMK6zBO0r0g1q
         3H9W2Tx23mLp1AzBXvSadlivUk+lpgzSKZM/SmBCIRGLfdCFgs6awRKUKsF4ER/6mk
         MZM0sEf8tTcrw==
Date:   Fri, 20 Aug 2021 12:17:49 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
        =?ISO-8859-1?Q?Christian_K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: Removing Mandatory Locks
User-Agent: K-9 Mail for Android
In-Reply-To: <202108200905.BE8AF7C@keescook>
References: <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com> <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com> <87h7ft2j68.fsf@disp2133> <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com> <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com> <YRcyqbpVqwwq3P6n@casper.infradead.org> <87k0kkxbjn.fsf_-_@disp2133> <0c2af732e4e9f74c9d20b09fc4b6cbae40351085.camel@kernel.org> <CAHk-=wgewmbABDC3_ZNn11C+sm4Uz0L9HZ5Kvx0Joho4vsV4DQ@mail.gmail.com> <202108200905.BE8AF7C@keescook>
Message-ID: <D2325492-F4DD-4E7A-B4F1-0E595FF2469A@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I thought the main user was Samba and/or otherwise providing file service f=
or M$ systems?

On August 20, 2021 9:30:31 AM PDT, Kees Cook <keescook@chromium=2Eorg> wro=
te:
>On Thu, Aug 19, 2021 at 12:15:08PM -0700, Linus Torvalds wrote:
>> On Thu, Aug 19, 2021 at 11:39 AM Jeff Layton <jlayton@kernel=2Eorg> wro=
te:
>> >
>> > I'm all for ripping it out too=2E It's an insane interface anyway=2E
>> >
>> > I've not heard a single complaint about this being turned off in
>> > fedora/rhel or any other distro that has this disabled=2E
>>=20
>> I'd love to remove it, we could absolutely test it=2E The fact that
>> several major distros have it disabled makes me think it's fine=2E
>
>FWIW, it is now disabled in Ubuntu too:
>
>https://git=2Elaunchpad=2Enet/~ubuntu-kernel/ubuntu/+source/linux/+git/im=
pish/commit/?h=3Dmaster-next&id=3Df3aac5e47789cbeb3177a14d3d2a06575249e14b
>
>> But as always, it would be good to check Android=2E
>
>It looks like it's enabled (checking the Pixel 4 kernel image), but it's
>not specifically mentioned in any of the build configs that are used to
>construct the image, so I think this is just catching the "default y"=2E =
I
>expect it'd be fine to turn this off=2E
>
>I will ask around to see if it's actually used=2E
>

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
