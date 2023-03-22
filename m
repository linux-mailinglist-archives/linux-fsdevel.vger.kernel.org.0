Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994FD6C4B0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 13:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCVMso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 08:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCVMsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:48:42 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5300DB770;
        Wed, 22 Mar 2023 05:48:41 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id i22so12515324uat.8;
        Wed, 22 Mar 2023 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679489320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3oCNWppbROd6SSbXVVTTvNwlzOezQhHcc6I5uo2B6o=;
        b=jkLoSQeZoj7lPy3YyjlsVsMY8EyX+PKWGwOqo5C2ioV84YccIr3jRx+beabTLQWAcm
         dX13QrMNNSAdxPuqzedkdFMQqfXagX0CkiBz2fUE+Y46TNyt5Q99WvD1fs4QW36u4UfQ
         9E7hMp10kDZBAVN0iLRtHEp3FUQOMWgazedgc7NkcEJppi7mbDU0gkt/e3MU2tHfVKqG
         6iHZjoyEuzH3e/vLmQTkksMyXyP14EFYKysuWwhkPAOwJGqzQFyC+KNPBQa3/69HvG4P
         l4aohuTWFo3TzEXsEdmqlw40xr7KD9Hqcz+TEDWQH4tm2W7krm6TbbgFL0qjamhLt41r
         u3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3oCNWppbROd6SSbXVVTTvNwlzOezQhHcc6I5uo2B6o=;
        b=nzhiYNubZLmN5l3Er6ZsLrxposCsemrFBbcCrykWENo/sjjmsNrknKj4EfQPl1VD2I
         ARf/Nt7f3rrOsR0+BrCRiddyQSix5/MDcV4yjGRhTSd0afzqJMhOLu5n7aB0rEkExvpn
         s7urOS8TzW0R2Mz6FhB4Jos1svXBRQKIwkidbm3lsQDEJeOPX7GZ8LCrslw8F7QAvEnH
         paN3CuIzx/oHOnq5dVwkaWJZfWsyjZ2v/0aRwWau/I/vYoBHFKt9K0DW81wrTxKRSym4
         e4RPfMsBf11x+Uo5JiOtXMkAfWY2yH9uccEcqRYU0aZCtv/S2aK+OHs93aHH297o53t5
         M5ag==
X-Gm-Message-State: AO0yUKVLqX3mzSTaHKKjIxfjxqCZU+oOt4jUw7mY7IsuDrOUojvrH+MH
        6DC4qZ/aJ1Z5oizaenXkP9xQZfwD6r1z4xRsx2o=
X-Google-Smtp-Source: AK7set/X+NyRJ6USDPXg3DEszeyebaLGd4pwgf3cHSfLLffG9nVVa2N7HRukXTPNJdgcyeb18X+C5ORBCTlBy5oo/4s=
X-Received: by 2002:a1f:1e0a:0:b0:406:6b94:c4fe with SMTP id
 e10-20020a1f1e0a000000b004066b94c4femr3280697vke.0.1679489320234; Wed, 22 Mar
 2023 05:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <Yao51m9EXszPsxNN@redhat.com> <CAOQ4uxjk4piLyx67Ena-FfypDVWzRqVN0xmFUXXPYa+SC4Q-vQ@mail.gmail.com>
 <YapjNRrjpDu2a5qQ@redhat.com> <CAHC9VhQTUgBRBEz_wFX8daSA70nGJCJLXj8Yvcqr5+DHcfDmwA@mail.gmail.com>
 <CA+FmFJA-r+JgMqObNCvE_X+L6jxWtDrczM9Jh0L38Fq-6mnbbA@mail.gmail.com>
 <CAHC9VhRer7UWdZyizWO4VuxrgQDnLCOyj8LO7P6T5BGjd=s9zQ@mail.gmail.com>
 <CAHC9VhQkLSBGQ-F5Oi9p3G6L7Bf_jQMWAxug_G4bSOJ0_cYXxQ@mail.gmail.com>
 <CAOQ4uxhfU+LGunL3cweorPPdoCXCZU0xMtF=MekOAe-F-68t_Q@mail.gmail.com>
 <YitWOqzIRjnP1lok@redhat.com> <CAHC9VhQ+x3ko+=oU-P+w4ssqyyskRxaKsBGJLnXtP_NzWNuxHg@mail.gmail.com>
 <20230322072850.GA18056@suse.de>
In-Reply-To: <20230322072850.GA18056@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 22 Mar 2023 14:48:29 +0200
Message-ID: <CAOQ4uxgH905R1dkQy5=tuG4nnB-p2XUWcf91vvYbfu2DyftzPw@mail.gmail.com>
Subject: Re: [PATCH v19 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Johannes Segitz <jsegitz@suse.com>
Cc:     Paul Moore <paul@paul-moore.com>, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Anderson <dvander@google.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Stultz <john.stultz@linaro.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        kernel-team <kernel-team@android.com>, selinux@vger.kernel.org,
        paulmoore@microsoft.com, luca.boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 9:28=E2=80=AFAM Johannes Segitz <jsegitz@suse.com> =
wrote:
>
> On Fri, Mar 11, 2022 at 03:52:54PM -0500, Paul Moore wrote:
> > On Fri, Mar 11, 2022 at 9:01 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > Agreed. After going through the patch set, I was wondering what's the
> > > overall security model and how to visualize that.
> > >
> > > So probably there needs to be a documentation patch which explains
> > > what's the new security model and how does it work.
> >
> > Yes, of course.  I'll be sure to add a section to the existing docs.
> >
> > > Also think both in terms of DAC and MAC. (Instead of just focussing t=
oo
> > > hard on SELinux).
> >
> > Definitely.  Most of what I've been thinking about the past day or so
> > has been how to properly handle some of the DAC/capability issues; I
> > have yet to start playing with the code, but for the most part I think
> > the MAC/SELinux bits are already working properly.
> >
> > > My understanding is that in current model, some of the overlayfs
> > > operations require priviliges. So mounter is supposed to be privilige=
d
> > > and does the operation on underlying layers.
> > >
> > > Now in this new model, there will be two levels of check. Both overla=
y
> > > level and underlying layer checks will happen in the context of task
> > > which is doing the operation. So first of all, all tasks will need
> > > to have enough priviliges to be able to perform various operations
> > > on lower layer.
> > >
> > > If we do checks at both the levels in with the creds of calling task,
> > > I guess that probably is fine. (But will require a closer code inspec=
tion
> > > to make sure there is no privilege escalation both for mounter as wel=
l
> > > calling task).
> >
> > I have thoughts on this, but I don't think I'm yet in a position to
> > debate this in depth just yet; I still need to finish poking around
> > the code and playing with a few things :)
> >
> > It may take some time before I'm back with patches, but I appreciate
> > all of the tips and insight - thank you!
>
> Let me resurrect this discussion. With
> https://github.com/fedora-selinux/selinux-policy/commit/1e8688ea694393c9d=
918939322b72dfb44a01792
> the Fedora policy changed kernel_t to a confined domain. This means that
> many overlayfs setups that are created in initrd will now run into issues=
,
> as it will have kernel_t as part of the saved credentials. So while the
> original use case that inspired the patch set was probably not very commo=
n
> that now changed.

I don't remember anyone rejecting the patches on the account that
the Android use case is not important. It was never the issue.

>
> It's tricky to work around this. Loading a policy in initrd causes a lot =
of
> issues now that kernel_t isn't unconfined anymore. Once the policy is
> loaded by systemd changing the mounts is tough since we use it for /etc a=
nd
> at this time systemd already has open file handles for policy files in
> /etc.
>

I've already explained several times on this thread what needs to be
done in order to move forward - express the security model and
explain why it is safe.

If the security guys are going to be in LSS in Vancouver, perhaps
we can have a meetup with overlayfs developers on the overlap
day with LSFMM (May 10) to try and figure out a path forward.

Thanks,
Amir.
