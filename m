Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5F660328A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJRScd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJRScc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:32:32 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD6F88A0B
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 11:32:30 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i127so7262873ybc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L16nsXH834AKuMsM1DMh0J2GdKedU+LxwtqcL0kTxPI=;
        b=XO8YUb/HBgZcSFvKYW3v1o26TnjeGANLpJgT83ktEA5S3Wpn8WFZv1ed3CMM3+J+2M
         BZy26UEEhByJ/XoGJuZMOT70oocT1eWbj1tLh2Y05Y9NNDzK3f5PWHipzgAtlbBsTCd6
         z1uWBMk+2CzW7mvcTmvhwAFbUpRAHM2d3K+NNH4uyCu+TuNeU/EyxIXMq9RxRoVeaY3R
         YnRpBEZ+pNJUGKqB6hHn2TOYXx8KD5M398NxDBe1fooI4f1dfNY0GnWJR71p1MLgb3x9
         FxW4UmbW9u+j2FVcEubUkGusDH8gGJAxJtHMYJNxZrved0o3fbCGFZYNZYhT4fIIRjzo
         Iq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L16nsXH834AKuMsM1DMh0J2GdKedU+LxwtqcL0kTxPI=;
        b=flNrfIUOAbKTAsyWbUYJeB6FX9JDnb4Jk5yDKTQt16YYrD7FRkXvvyfldxKA8OjPFq
         snFBzioRn2ov47DZoxT7hNa75K6nryn8XFKwaKSwniYozDdsdGEDAJ/2JYqNNQ32QOrg
         QgvwQoczIQnxP9ExtmfzXJZWurkKt4IOowjuBeD40yAyg7EmWWACbmek3c838uS3d9t/
         ADEqyBlNyRWYULkdkk9zlszpLTj2XOrO2mDFeeR7c6+JgisOOc1Ufyp4B8o0XuxnnYa8
         7nGWDpDvvnHpSpihwt0B9ieUuPdN5RPQsjZ/jvvtHD/WvhVOyJfcVCzwGHlEo7PR5Py7
         gDeg==
X-Gm-Message-State: ACrzQf0IVUwsKVTrmiZEfXUF2aitCaFvq6XbObZY8JAVd4HPc82EKJH9
        7h4CIsP93z4A/KfWeYDacn7eF/SPZwky3IR8VQVf
X-Google-Smtp-Source: AMsMyM549fr2F8ghdaTmpS/lhPUsehNpD3P88Hit4TOUZZUVZsJ34NGZDgq0dmFRGFU5YGCDaHopXFJifv1b36RZvn0=
X-Received: by 2002:a05:6902:724:b0:6c0:1784:b6c7 with SMTP id
 l4-20020a056902072400b006c01784b6c7mr3615835ybt.15.1666117949646; Tue, 18 Oct
 2022 11:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221008100935.73706-1-gnoack3000@gmail.com> <b8566973-63bc-441f-96b9-f822e9944127@digikod.net>
 <Y0g+TEgGGhZDm7MX@dev-arch.thelio-3990X> <Y0xJUy3igQXWPAeq@nuc>
 <Y0xkZqKoE3rRJefh@nuc> <ea8117e5-7f5c-7598-5d6a-868184a6e4ae@digikod.net>
 <CAHC9VhR8SQo9x_cv6BZQSwt0rrjeGh-t+YV10GrA3PbC+yHrxw@mail.gmail.com> <Y07rP/YNYxvQzOei@nuc>
In-Reply-To: <Y07rP/YNYxvQzOei@nuc>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Oct 2022 14:32:18 -0400
Message-ID: <CAHC9VhRamtwyA00A1j+8cd+UtZy7THu6VFch6qe0ESTx+bc+jA@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] landlock: truncate support
To:     =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 2:06 PM G=C3=BCnther Noack <gnoack3000@gmail.com> w=
rote:
>
> On Tue, Oct 18, 2022 at 01:12:48PM -0400, Paul Moore wrote:
> > On Mon, Oct 17, 2022 at 5:16 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
> > > On 16/10/2022 22:07, G=C3=BCnther Noack wrote:
> >
> > ...
> >
> > > > Proposed fix
> > > > ------------
> > > >
> > > > I think the LSM framework should ensure that security blobs are
> > > > pointer-aligned.
> > > >
> > > > The LSM framework takes the role of a memory allocator here, and
> > > > memory allocators should normally return aligned addresses, in my
> > > > understanding. -- It seems reasonable for AppArmor to make that
> > > > assumption.
> > > >
> > > > The proposed one-line fix is: Change lsm_set_blob_size() in
> > > > security/security.c, where the positions of the individual security
> > > > blobs are calculated, so that each allocated blob is aligned to a
> > > > pointer size boundary.
> > > >
> > > > if (*need > 0) {
> > > >    *lbs =3D ALIGN(*lbs, sizeof(void *));   // NEW
> > > >
> > > >    offset =3D *lbs;
> > > >    *lbs +=3D *need;
> > > >    *need =3D offset;
> > > > }
> > >
> > > This looks good to me. This fix should be part of patch 4/11 since it
> > > only affects Landlock for now.
> >
> > Hi G=C3=BCnther,
> >
> > Sorry for not seeing this email sooner; I had thought the landlock
> > truncate work was largely resolved with just a few small things for
> > you to sort out with Micka=C3=ABl so I wasn't following this thread ver=
y
> > closely anymore.
> >
> > Regarding the fix, yes, I think the solution is to fixup the LSM
> > security blob allocator to properly align the entries.  As you already
> > mentioned, that's common behavior elsewhere and I see no reason why we
> > should deviate from that in the LSM allocator.  Honestly, looking at
> > the rest of the allocator right now I can see a few other things to
> > improve, but those can wait for a later time so as to not conflict
> > with this work (/me adds a new entry to my todo list).
> >
> > Other than that, I might suggest the lsm_set_blob_size()
> > implementation below as it seems cleaner to me and should be
> > functionally equivalent ... at least on quick inspection, if I've done
> > something dumb with the code below please feel free to ignore me ;)
> >
> >   static void __init lsm_set_blob_size(int *need, int *lbs)
> >   {
> >     if (*need <=3D 0)
> >       return;
> >
> >     *need =3D ALIGN(*need, sizeof(void *));
> >     *lbs +=3D *need;
> >   }
>
> Hello Paul,
>
> thanks for the reply. Sounds good, I'll go forward with this approach
> then and send a V10 soon.
>
> Implementation-wise for this function, I think this is the closest to
> your suggestion I can get:
>
> static void __init lsm_set_blob_size(int *need, int *lbs)
> {
>   int offset;
>
>   if (*need <=3D 0)
>     return;
>
>   offset =3D ALIGN(*lbs, sizeof(void *));
>   *lbs =3D offset + *need;
>   *need =3D offset;
> }
>
> This differs from your suggestion in that:
>
> - *need gets assigned to the offset at the end. (It's a bit unusual:
>   *need is both used to specify the requested blob size when calling
>   the function, and for returning the allocated offset from the
>   function call.)
>
> - This implementation aligns the blob's start offset, not the end
>   offset. (probably makes no real difference in practice)
>
> As suggested by Micka=C3=ABl, I'll make this fix part of the "Landlock:
> Support file truncation" patch, so that people backporting it won't
> accidentally leave it out.

That's all fine with me, the important thing is to make sure the
landlock truncate patches don't break anything.  We'll cleanup the
allocator later.

--=20
paul-moore.com
