Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FE0916F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 16:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfHROAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 10:00:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46266 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfHROAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 10:00:24 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so15346579iog.13;
        Sun, 18 Aug 2019 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Lox1GwVXn3FfNaJc4tSQNHxrlDnE7ZTtqmRrPEy0V0=;
        b=bgIJNrZLD9cEQKaX+WWl784pUPlA/tMWOGODRlCV0cwRfljdDw0TQroLAlEh8uMvR7
         mRRaLCdUQE/DuVODp7dMxuEwKDsVq0zg8btmhZPhV0glEfeilVGnBJOlnXzuUfEBEwSv
         lDSF11fy3DbrG7VimGQkh1nc/jGSgughWyUnzo3SvMFOpLm5DMx9KxTX+49HSr5ay9+n
         zQiuA8ep8ndPO8CU4tSO0ANyWPzCPlOhqNXXCIjpu3t+KihQ4gNrjclIVDoWQjqa+RAi
         aAof1xBUuM09Jdg1Uoumte0u6KtApThoryqZ4uwApj1DYcQt3AO9pKGjCpi0+4UCGY71
         MgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Lox1GwVXn3FfNaJc4tSQNHxrlDnE7ZTtqmRrPEy0V0=;
        b=Dby5ICIi/oaJ8+XFJiXtuEvLDUEfVe00MofwWsYb8KE0VWbUo8uuiat4qo9C/Dap9k
         Yv488eRXRBNK7MGv2Y7LYr4AaTqb/9g0HIgH3QyNGDyeSsBL05/faQZbGnwDAz9Dejfi
         1tuMERYdgFPD/OflW2abdfMdkrtrS4NHorzAQCVCcFeECb4kZ7NElkJ4xlZTJqqgToqS
         xd91V0IK/fpF6CE5PL9OSP86RuOa0tLaAmgg8Vbehlmhka9ek1zVu3758rOMK+wGMXIc
         PTJjq+v3CHxzmfiISyEf6/zLaatvqUvU0koAuikEuIRa5hYFzt1CcF1DVt7ckgo23LWg
         feIw==
X-Gm-Message-State: APjAAAWIw0ESXaqEYF4MikS02+aF3tpAex4AHyctcb233DnfMwqN/gcI
        C9JhDEgich4KZMhq72miI/bsGk1QanAUXpyr+vo=
X-Google-Smtp-Source: APXvYqxnImgJgmCUWa7dkjDd15eyh4IYUAjq63iKHeqQEvtSUIUevkYw9wGEuETJFb98Wxh4oq0CLfa0sHPYgtQcbq0=
X-Received: by 2002:a5d:8599:: with SMTP id f25mr2358917ioj.265.1566136823400;
 Sun, 18 Aug 2019 07:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-20-deepa.kernel@gmail.com>
 <201907292129.AC796230@keescook> <CAK8P3a2rWEciT=PegCYUww-n-3smQHNjvW4duBqoS2PLSGdhYw@mail.gmail.com>
 <CABeXuvrmNkUOH5ZU59Kg4Ge1cFE9nqp9NhTPJjus5KkCrYeC6w@mail.gmail.com> <CAK8P3a3DyWcvOpMsc__CZDmG50MXRisbBt+mTtwWCGKaNgg_Gg@mail.gmail.com>
In-Reply-To: <CAK8P3a3DyWcvOpMsc__CZDmG50MXRisbBt+mTtwWCGKaNgg_Gg@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 18 Aug 2019 07:00:12 -0700
Message-ID: <CABeXuvr=t4zM060UKJBv0nywGkQjK915gvr6bv5=0_EbEctKHg@mail.gmail.com>
Subject: Re: [PATCH 19/20] pstore: fs superblock limits
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 2, 2019 at 12:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Aug 2, 2019 at 4:26 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > On Tue, Jul 30, 2019 at 12:36 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Jul 30, 2019 at 6:31 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Mon, Jul 29, 2019 at 06:49:23PM -0700, Deepa Dinamani wrote:
> > > > > Also update the gran since pstore has microsecond granularity.
> > > >
> > > > So, I'm fine with this, but technically the granularity depends on the
> > > > backend storage... many have no actual time keeping, though. My point is,
> > > > pstore's timestamps are really mostly a lie, but the most common backend
> > > > (ramoops) is seconds-granularity.
> > > >
> > > > So, I'm fine with this, but it's a lie but it's a lie that doesn't
> > > > matter, so ...
> > > >
> > > > Acked-by: Kees Cook <keescook@chromium.org>
> > > >
> > > > I'm open to suggestions to improve it...
> > >
> > > If we don't care about using sub-second granularity, then setting it
> > > to one second unconditionally here will make it always use that and
> > > report it correctly.
> >
> > Should this printf in ramoops_write_kmsg_hdr() also be fixed then?
> >
> >         RAMOOPS_KERNMSG_HDR "%lld.%06lu-%c\n",
> >         (time64_t)record->time.tv_sec,
> >         record->time.tv_nsec / 1000,
> >         record->compressed ? 'C' : 'D');
> >     persistent_ram_write(prz, hdr, len);
> >
> > ramoops_read_kmsg_hdr() doesn't read this as microseconds. Seems like
> > a mismatch from above.
>
> Good catch. This seems to go back to commit 3f8f80f0cfeb ("pstore/ram:
> Read and write to the 'compressed' flag of pstore"), which introduced the
> nanosecond read. The write function however has always used
> microseconds, and that was kept when the implementation changed
> from timeval to timespec in commit 1e817fb62cd1 ("time: create
> __getnstimeofday for WARNless calls").
>
> > If we want to agree that we just want seconds granularity for pstore,
> > we could replace the tv_nsec part to be all 0's if anybody else is
> > depending on this format.
> > I could drop this patch from the series and post that patch seperately.
>
> We should definitely fix it to not produce a bogus nanosecond value.
> Whether using full seconds or microsecond resolution is better here,
> I don't know. It seems that pstore records generally get created
> with a nanosecond nanosecond accurate timestamp from
> ktime_get_real_fast_ns() and then truncated to the resolution of the
> backend, rather than the normal jiffies-accurate inode timestamps that
> we have for regular file systems.
>
> This might mean that we do want the highest possible resolution
> and not further truncate here, in case that information ends
> up being useful afterwards.

I made a list of granularities used by pstore drivers using pstore_register():

1. efi - seconds
2. ramoops - microsecond
3. erst - seconds
4. powerpc/nvram64 - seconds

I will leave pstore granularity at nanoseconds and fix the ramoops read.

-Deepa
