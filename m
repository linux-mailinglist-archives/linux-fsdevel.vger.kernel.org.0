Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6026154D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 18:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgIHQsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 12:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731994AbgIHQrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:47:12 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B39C06137A;
        Tue,  8 Sep 2020 05:52:13 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e23so14728383otk.7;
        Tue, 08 Sep 2020 05:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RSBroElt/2rd8PC1JxxbAAzGUdGD8+TpQ3WZUmiUhpM=;
        b=eTCVIzNm1ErwySELQBxnMmM/AgczXHFoHr7tAYK0AzvrrFpGaltdTw3BU3s6nbzZwV
         FVze43SwEAqT9SvAQmGOzyCxUMdZtymO/iomH+o46b3/yM0Ox9AJ3+9Xn2WMnWTK0Bc3
         M2VQ+2ueKbAh3cxEBdKEnnfwm2WR+1pf/wzXaClR2OEX+s2dpP4cdruEpT01B2oKaCgT
         WAyhBPyfgKh1zK7exA8S4xxepCiPC2CX0rFJd9/j1ZBlLdrkBQj4c0Vf0Iq6RPftxU89
         +cgdAfBDF5x1mUuE2nCFjBhzD7FADAqHMbVgOC1KJQAzh/bpLmx1qjElc/fALXBLVFU9
         hajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RSBroElt/2rd8PC1JxxbAAzGUdGD8+TpQ3WZUmiUhpM=;
        b=HFCoLr3qa9KDqPLImsrK5qzR1iAcNcPCAC7iJW+sUuZKhrNU30zAawR0ITu1l9roWg
         eeErUaO0N153M5A5Y6e+v+koUbdB/fA0uouRJmuqH/VGhsADfswBWdHK7bl9T7mEvkNZ
         g+98ADvbpVjyZ4oJ8Uah9RywW+JI8+rZ9mAtS2/vy3LtCBWwxnxaV48vErY7+a341/Zx
         MYhTZhMLDKAnPLE96izXi2+yJl9UwFO4qIS+KE5W+Hmr96TewKWvO53gvihMTyBvTC3h
         dRoSWmjQ6PgiBiPFzFSWcw4IUlWYnHzcL772sEDxQDYW5gny5JENu07g3lHWPImiDYPS
         p8Rg==
X-Gm-Message-State: AOAM5339VplX8qn2Hc0nCIcXHEY3b8S/pJgpnYA/PdIhGGeQkNVoCUJq
        ki7oS8H/LSWv73cFY0RNq7FV8IFZ2DHy2ZPR7Ik=
X-Google-Smtp-Source: ABdhPJxkV3KPZWICtf1txHSRVep4rHIt7AdIIVwPHFJWR6ocRJEX5qRfN+Lfgk+mF/ZkzhvREH+BKcYfiF/pqjxb3rI=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr16914681otn.89.1599569532734;
 Tue, 08 Sep 2020 05:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200908075956.1069018-1-mic@digikod.net> <20200908075956.1069018-2-mic@digikod.net>
 <d216615b48c093ebe9349a9dab3830b646575391.camel@linux.ibm.com>
 <75451684-58f3-b946-dca4-4760fa0d7440@digikod.net> <CAEjxPJ49_BgGX50ZAhHh79Qy3OMN6sssnUHT_2yXqdmgyt==9w@mail.gmail.com>
In-Reply-To: <CAEjxPJ49_BgGX50ZAhHh79Qy3OMN6sssnUHT_2yXqdmgyt==9w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 8 Sep 2020 08:52:01 -0400
Message-ID: <CAEjxPJ6ZTKeunzJvWf_kS3QYjca6v1yJq=ad-jCCuDSgG6n60g@mail.gmail.com>
Subject: Re: [RFC PATCH v8 1/3] fs: Introduce AT_INTERPRETED flag for faccessat2(2)
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 8, 2020 at 8:50 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Sep 8, 2020 at 8:43 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> >
> >
> > On 08/09/2020 14:28, Mimi Zohar wrote:
> > > Hi Mickael,
> > >
> > > On Tue, 2020-09-08 at 09:59 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > >> +                    mode |=3D MAY_INTERPRETED_EXEC;
> > >> +                    /*
> > >> +                     * For compatibility reasons, if the system-wid=
e policy
> > >> +                     * doesn't enforce file permission checks, then
> > >> +                     * replaces the execute permission request with=
 a read
> > >> +                     * permission request.
> > >> +                     */
> > >> +                    mode &=3D ~MAY_EXEC;
> > >> +                    /* To be executed *by* user space, files must b=
e readable. */
> > >> +                    mode |=3D MAY_READ;
> > >
> > > After this change, I'm wondering if it makes sense to add a call to
> > > security_file_permission().  IMA doesn't currently define it, but
> > > could.
> >
> > Yes, that's the idea. We could replace the following inode_permission()
> > with file_permission(). I'm not sure how this will impact other LSMs th=
ough.
>
> They are not equivalent at least as far as SELinux is concerned.
> security_file_permission() was only to be used to revalidate
> read/write permissions previously checked at file open to support
> policy changes and file or process label changes.  We'd have to modify
> the SELinux hook if we wanted to have it check execute access even if
> nothing has changed since open time.

Also Smack doesn't appear to implement file_permission at all, so it
would skip Smack checking.
