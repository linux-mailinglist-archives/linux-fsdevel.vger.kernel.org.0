Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1CD6AF76A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 22:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCGVWI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 16:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCGVWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:22:06 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D729DE1A
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 13:22:05 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536c02c9dfbso268689387b3.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 13:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678224125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ix+rz8/Cgkdlv6+uECDU6NopcnuqQRV5cx3kDDiFh8Q=;
        b=jPGlnvYPXnj6sY3e3wnH2CKmwP+bxvCmgMXJFEoCPLjFskYphPavq8nFeGzPemVqUd
         V7c1v4KGLSesT7wUtl/6is5w3dpAKe0/t8sxf/p85w4PpWKcUcWVvsJQyPiL0AB/dI2I
         8Y7ZwE95vik8WG9ElQnIi9oLfwiVF3njs3GVct5Xiz8tNZfJ+Hc/biWKpUtlui9e8aXT
         e5xvJbuWPjvlOJrE+inq3YpogISAW8cuNaooAgXFRDcCxLnaBsYdkd6JJ9caBaZshBtX
         1RZRQ7CKAXUUM4V1nAhsKosvoFdsDpC+LZFaCW/T4nMFy7PtsWoHgbnz2gC7xW012WPJ
         WEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678224125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ix+rz8/Cgkdlv6+uECDU6NopcnuqQRV5cx3kDDiFh8Q=;
        b=rrDZ/X8z1H+5VhDHOhiJJzl16w9wDUokbeYhAlXd7yGvsfBNlgxCEBqsPZjR/4Y42U
         +r6M/sEkhZYgzUxjb+IL3gsf8vyItxmuZ5p6tcMYRGZMLpAoOWLuDtOUAYfoUU+ADceg
         mcJxXK3s29BfaGNwqWpnGIrPz8Il0nQ8EtmuTXJak1XnokmvwRjKNM3Zu65fgBQr4YnK
         jri/31fs59FQ63kb4I79oowuBkTaylL9CZ8z8YGSVkwYYX6Iu2yVeUJWAfILyqosPMbb
         Tjp4c4DhatUybgWjv3bYMQ+FHqPSmT9pA45fEowsyWTp6haUZHl5OmctPVz/vdQ4v4Ii
         yzig==
X-Gm-Message-State: AO0yUKXhG3y2jlfGmiRG+XTJ+kYllIr6187OQ3hkneLPkegg0HqJ2sbh
        9lfo+fW6G8KuH9yawuWtYR1I1eMWUquS22t7PJ8RXQ==
X-Google-Smtp-Source: AK7set9ogEoXjKLSGYP4LNAsO6Wu44RKFwsr+WT5Vgcv0blZpxfFNL9xJ6zzOMkLcF8VIYNM2T7c/1h++I6kybekwvU=
X-Received: by 2002:a81:ac4c:0:b0:533:9ffb:cb11 with SMTP id
 z12-20020a81ac4c000000b005339ffbcb11mr10285814ywj.7.1678224123295; Tue, 07
 Mar 2023 13:22:03 -0800 (PST)
MIME-Version: 1.0
References: <e8228f0048977456466bc33b42600e929fedd319.1678213651.git.pabeni@redhat.com>
 <CO1PR11MB5089C96D23A1D6F0F121716DD6B79@CO1PR11MB5089.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB5089C96D23A1D6F0F121716DD6B79@CO1PR11MB5089.namprd11.prod.outlook.com>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Tue, 7 Mar 2023 16:21:27 -0500
Message-ID: <CACSApvY_pj-tReFEpoH5e6xvUuk2ih9Nc+cc6AZzd5yvFCiTQg@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND] epoll: use refcount to reduce ep_mutex contention
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 7, 2023 at 4:17=E2=80=AFPM Keller, Jacob E <jacob.e.keller@inte=
l.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Paolo Abeni <pabeni@redhat.com>
> > Sent: Tuesday, March 7, 2023 10:47 AM
> > To: netdev@vger.kernel.org
> > Cc: Soheil Hassas Yeganeh <soheil@google.com>; Al Viro
> > <viro@zeniv.linux.org.uk>; Carlos Maiolino <cmaiolino@redhat.com>; Eric
> > Biggers <ebiggers@kernel.org>; Keller, Jacob E <jacob.e.keller@intel.co=
m>;
> > Andrew Morton <akpm@linux-foundation.org>; Jens Axboe <axboe@kernel.dk>=
;
> > Christian Brauner <brauner@kernel.org>; linux-fsdevel@vger.kernel.org
> > Subject: [PATCH v4 RESEND] epoll: use refcount to reduce ep_mutex conte=
ntion
> >
> > We are observing huge contention on the epmutex during an http
> > connection/rate test:
> >
> >  83.17% 0.25%  nginx            [kernel.kallsyms]         [k]
> > entry_SYSCALL_64_after_hwframe
> > [...]
> >            |--66.96%--__fput
> >                       |--60.04%--eventpoll_release_file
> >                                  |--58.41%--__mutex_lock.isra.6
> >                                            |--56.56%--osq_lock
> >
> > The application is multi-threaded, creates a new epoll entry for
> > each incoming connection, and does not delete it before the
> > connection shutdown - that is, before the connection's fd close().
> >
> > Many different threads compete frequently for the epmutex lock,
> > affecting the overall performance.
> >
> > To reduce the contention this patch introduces explicit reference count=
ing
> > for the eventpoll struct. Each registered event acquires a reference,
> > and references are released at ep_remove() time.
> >
> > Additionally, this introduces a new 'dying' flag to prevent races betwe=
en
> > the EP file close() and the monitored file close().
> > ep_eventpoll_release() marks, under f_lock spinlock, each epitem as bef=
ore
> > removing it, while EP file close() does not touch dying epitems.
> >
> > The eventpoll struct is released by whoever - among EP file close() and
> > and the monitored file close() drops its last reference.
> >
> > With all the above in place, we can drop the epmutex usage at disposal =
time.
> >
> > Overall this produces a significant performance improvement in the
> > mentioned connection/rate scenario: the mutex operations disappear from
> > the topmost offenders in the perf report, and the measured connections/=
rate
> > grows by ~60%.
> >
> > To make the change more readable this additionally renames ep_free() to
> > ep_clear_and_put(), and moves the actual memory cleanup in a separate
> > ep_free() helper.
> >
> > Tested-by: Xiumei Mu <xmu@redhiat.com>
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > This is a repost of v4, with no changes. Kindly asking if FS maintainer=
s
> > could have a look.
>
> This (still) looks good to me.
>
> Thanks,
> Jake

Thank you! Still looks great to me as well.
