Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8942D6B61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 00:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbgLJXAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 18:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389147AbgLJXAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:00:00 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842DCC0613D6;
        Thu, 10 Dec 2020 14:59:45 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a16so9727690ejj.5;
        Thu, 10 Dec 2020 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w4RoiRpMZZxF8v+p7+K9+rxFAVC8Se6OED65j8jCSlY=;
        b=UYuiba7yBHsbVW0SRWhDYM/XceI9ZnLbHk0IalVl3ztWWzp0rbP+C8J/bxI1FlZLlb
         4CsRBcBzNJ/TnF7HVkwyHDmMV8rQHbUtlp9xWr/1SFfU1xdc4l1IySp0VSaxSSxPWrGX
         wZXsxMe0fesQT3WOEJ3UNpOZF1Ls1dEW1psepTCzbdsRi07CIB3WuOJ8CzOwhnVsTtGO
         LbT1ow94GvZKzSxwb20lM6ainU9w7EfkZR404h/7l7l0hNcjVbfd3n66SfNqYQlAWylT
         ot/Mj3vsZQDAqz3Ac0YvIY3IbECHZxJmCiLPBxRSIViGnGyBz3xBwtuMNA+rtzZ17jby
         5aRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w4RoiRpMZZxF8v+p7+K9+rxFAVC8Se6OED65j8jCSlY=;
        b=q3uZIY3q7bWAOE86ADuMUav8Nlr/Yh00fduBqTNDTYLQVCrGC56jFXox+2h46TAJ7E
         BoC9Dids4+xDEVPlrxE45SrWi2yHrhVR/lnO6DnWSniV/HdiTD8A5xMjDk0X4JVo5uWv
         J6jqOxpAJJQG5yRDyIHHXrxAbCemC74u5lONT/a0PvdPQ/v2J3g+Kp1g+RqnxzysPBzZ
         yXRaaNBFbiz/M+EIbdiHfrVzP3CBAZ8dUjonxl8FbJPGyjDPntBksuf/2PWq7SiPpjo8
         sdv1WlvRUgTlX7PjVLOXdesrcqX3KK/Kj69sWoZv4qFjEFBr1Z8kitPDdjQnZOsk/ZeM
         GRmg==
X-Gm-Message-State: AOAM5322F2WDZwfdwp4HJ22Du9TBSI0lDMyrrNLpgVWxEmp5Medeoz14
        FGpU2fn1lPoT594tNF38uuMIhaFC3VRkdptY788=
X-Google-Smtp-Source: ABdhPJyjXjSNLPh+kkQdb7gD7LXqrv6nedj8mxhlsVbNbhok0qlzNVOQZs2lazEKad8xY/0Fjnj4xXRsGJyKZgSFL6M=
X-Received: by 2002:a17:906:e94c:: with SMTP id jw12mr8617195ejb.56.1607641184237;
 Thu, 10 Dec 2020 14:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com> <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
 <20201119143131.GG29991@casper.infradead.org> <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
 <CAF=yD-Kd-6f9wAYLD=dP1pk4qncWim424Fu6Hgj=ZrnUtEPORA@mail.gmail.com>
 <CAK8P3a21JRFUJrz1+TYWcVL8s4uSfeSFyoMkGsqUPbV+F=r_yw@mail.gmail.com>
 <CAF=yD-Lzu9j6T4ubRjawF-EKOC3pkQTkpigg=PugWwybY-1ZyQ@mail.gmail.com>
 <CAK8P3a1cJf7+b5HCmFiLq+FdM+D+37rHYaftRgRYbhTyjwR6wg@mail.gmail.com>
 <CAF=yD-LdtCCY=Mg9CruZHdjBXV6VmEPydzwfcE2BHUC8z7Xgng@mail.gmail.com>
 <CAK8P3a2WifcGmmFzSLC4-0SKsv0RT231P6TVKpWm=j927ykmQg@mail.gmail.com>
 <CA+FuTSdPir68M9PwhuCkd_Saz-Wi3xa_rNuwvbNmpAkMjOqhuA@mail.gmail.com> <CAK8P3a2Z=X68aU27qQ_0vK6c_oj9CVbThuGscjqKXRCYKfFpgg@mail.gmail.com>
In-Reply-To: <CAK8P3a2Z=X68aU27qQ_0vK6c_oj9CVbThuGscjqKXRCYKfFpgg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 10 Dec 2020 17:59:07 -0500
Message-ID: <CAF=yD-LAzjyNRy0vqToWqx5LxeQMYY3fVzV0vr0X7Q70ZAR-AQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 3:34 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Thu, Dec 10, 2020 at 6:33 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> > On Sat, Nov 21, 2020 at 4:27 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > > On Fri, Nov 20, 2020 at 11:28 PM Willem de Bruijn <willemdebruijn.ker=
nel@gmail.com> wrote:
> > > I would imagine this can be done like the way I proposed
> > > for get_bitmap() in sys_migrate_pages:
> > >
> > > https://lore.kernel.org/lkml/20201102123151.2860165-4-arnd@kernel.org=
/
> >
> > Coming back to this. Current patchset includes new select and poll
> > selftests to verify the changes. I need to send a small kselftest
> > patch for that first.
> >
> > Assuming there's no time pressure, I will finish up and send the main
> > changes after the merge window, for the next release then.
> >
> > Current state against linux-next at
> > https://github.com/wdebruij/linux-next-mirror/tree/select-compat-1
>
> Ok, sounds good to me. I've had a (very brief) look and have one
> suggestion: instead of open-coding the compat vs native mode
> in multiple places like
>
> if (!in_compat_syscall())
>     =EF=BF=BC return copy_from_user(fdset, ufdset, FDS_BYTES(nr)) ? -EFAU=
LT : 0;
> else
>     =EF=BF=BC return compat_get_bitmap(fdset, ufdset, nr);
>
> maybe move this into a separate function and call that where needed.
>
> I've done this for the get_bitmap() function in my series at
>
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commi=
t/?h=3Dcompat-alloc-user-space-7&id=3Db1b23ebb12b635654a2060df49455167a142c=
5d2
>
> The definition is slightly differrent for cpumask, nodemask and fd_set,
> so we'd need to try out the best way to structure the code to end
> up with the most readable version, but it should be possible when
> there are only three callers (and duplicating the function would
> be the end of the world either)

For fd_set there is only a single caller for each direction. Do you
prefer helpers even so?

For sigmask, with three callers, something along the lines of this?

  @@ -1138,10 +1135,7 @@ static int do_ppoll(struct pollfd __user
*ufds, unsigned int nfds,
                          return -EINVAL;
          }

  -       if (!in_compat_syscall())
  -               ret =3D set_user_sigmask(sigmask, sigsetsize);
  -       else
  -               ret =3D set_compat_user_sigmask(sigmask, sigsetsize);
  +       ret =3D set_maybe_compat_user_sigmask(sigmask, sigsetsize);
          if (ret)
                  return ret;

  --- a/include/linux/compat.h
  +++ b/include/linux/compat.h
  @@ -942,6 +942,17 @@ static inline bool in_compat_syscall(void) {
return false; }

  +static inline int set_maybe_compat_user_sigmask(const void __user *sigma=
sk,
  +                                               size_t sigsetsize)
  +{
  +#if defined CONFIG_COMPAT
  +       if (unlikely(in_compat_syscall()))
  +               return set_compat_user_sigmask(sigmask, sigsetsize);
  +#endif
  +
  +       return set_user_sigmask(sigmask, sigsetsize);
  +}
