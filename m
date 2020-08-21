Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C564524E08B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 21:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgHUTPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 15:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgHUTPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:15:32 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB19C0613ED
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 12:15:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id si26so3578111ejb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stghTlyBapHk994fTHtMltbLyT6mOlKKkTF189OusPI=;
        b=VjNgrUm1v0IeHxdlDQ0CId/MrrRIGLSykTfWUhOMXaa+5c5Ox+rc6HV8mzndpk8qoI
         SlGp4gLF/RYuF3jYmM6JzdEZr9lKuv/dRZJpQ49hCQera3Cqt6s7k4BMzuKfiw6av94V
         c3lTpfClSIitbjMiPV26ArwYhM+shudRipL4ICzbvO653DXL74k0SxSHx/feRfR4Pl8O
         j0jOObYxDCZRdzWKMUAk6qiiJ3Hlqywc3HU4FWqit5X2R+q8/4y+0sM3IXTDe4dgCF//
         P+cTeJjQHezWI7/lkyQHpUTmarsZIlpTt2DKdHsGv005oUUel7Wa6PZa4ECzjTvkcrpb
         dBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stghTlyBapHk994fTHtMltbLyT6mOlKKkTF189OusPI=;
        b=hS31hkvKEGhlw5ELJJQs1NqR6qI2lKGpUTvGSse3aLsIZKITE+WpbMiFggVO4yN8H8
         ZQBHWo7dnq1zR5U4Y8aZ/a5tUzaJxUKwHWhzwZoAN1BeQ35T9Xvd/zb96/olMc3pHtEI
         6jSsChOd778sps3hwuJZhYtHv1P19n/GKAUkoPAr0XbhKjRmittMglC/24uRvwNN5r7c
         P8tC88Uj8vaq6+ltFqWQHDZ+ZJhjNlkeieYSqwpr+y8b6754IHJXC/QZHkBD9QGHhWhg
         v4FSP2W0woHaOmecE0Hl0hkaCj5tGcL0+GbqbnXJXxq0dORNh41iO/dkLPRZ+iX1zxm9
         8rzg==
X-Gm-Message-State: AOAM532eTdPpmFSSMG/mN+jekcnuANcw9B3AX1tNG3fP6iKIhAyduXF3
        nUGMrYYbOIN0eLt5GB5+QG0sP55vtzdu1ydBBUFf0s6fqE8UsSQ=
X-Google-Smtp-Source: ABdhPJyjrpQ5CVzgJ6gkhEM2fio8YtcBd5YLkjExur1qaET+X/RSJIK7uZHEgYYREA2rYWWgZrtfuZgNL32OaMUA+Aw=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr3986360eje.431.1598037328746;
 Fri, 21 Aug 2020 12:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <6e2e10432e1400f747918eeb93bf45029de2aa6c.1593198710.git.rgb@redhat.com>
 <CAHC9VhSCm5eeBcyY8bBsnxr-hK4rkso9_NJHJec2OXLu4m5QTA@mail.gmail.com> <20200729194058.kcbsqjhzunjpipgm@madcap2.tricolour.ca>
In-Reply-To: <20200729194058.kcbsqjhzunjpipgm@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 15:15:17 -0400
Message-ID: <CAHC9VhRUwCKBjffA_XNSjUwvUn8e6zfmy8WD203dK7R2KD0__g@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 05/13] audit: log container info of syscalls
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 29, 2020 at 3:41 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-07-05 11:10, Paul Moore wrote:
> > On Sat, Jun 27, 2020 at 9:22 AM Richard Guy Briggs <rgb@redhat.com> wrote:

...

> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index f03d3eb0752c..9e79645e5c0e 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -1458,6 +1466,7 @@ static void audit_log_exit(void)
> > >         struct audit_buffer *ab;
> > >         struct audit_aux_data *aux;
> > >         struct audit_names *n;
> > > +       struct audit_contobj *cont;
> > >
> > >         context->personality = current->personality;
> > >
> > > @@ -1541,7 +1550,7 @@ static void audit_log_exit(void)
> > >         for (aux = context->aux_pids; aux; aux = aux->next) {
> > >                 struct audit_aux_data_pids *axs = (void *)aux;
> > >
> > > -               for (i = 0; i < axs->pid_count; i++)
> > > +               for (i = 0; i < axs->pid_count; i++) {
> > >                         if (audit_log_pid_context(context, axs->target_pid[i],
> > >                                                   axs->target_auid[i],
> > >                                                   axs->target_uid[i],
> > > @@ -1549,14 +1558,20 @@ static void audit_log_exit(void)
> > >                                                   axs->target_sid[i],
> > >                                                   axs->target_comm[i]))
> > >                                 call_panic = 1;
> > > +                       audit_log_container_id(context, axs->target_cid[i]);
> > > +               }
> >
> > It might be nice to see an audit event example including the
> > ptrace/signal information.  I'm concerned there may be some confusion
> > about associating the different audit container IDs with the correct
> > information in the event.
>
> This is the subject of ghat81, which is a test for ptrace and signal
> records.
>
> This was the reason I had advocated for an op= field since there is a
> possibility of multiple contid records per event.

I think an "op=" field is the wrong way to link audit container ID to
a particular record.  It may be convenient, but I fear that it would
be overloading the field too much.

Like I said above, I think it would be good to see an audit event
example including the ptrace/signal information.  This way we can talk
about it on-list and hash out the various solutions if it proves to be
a problem.

> > > @@ -1575,6 +1590,14 @@ static void audit_log_exit(void)
> > >
> > >         audit_log_proctitle();
> > >
> > > +       rcu_read_lock();
> > > +       cont = _audit_contobj_get(current);
> > > +       rcu_read_unlock();
> > > +       audit_log_container_id(context, cont);
> > > +       rcu_read_lock();
> > > +       _audit_contobj_put(cont);
> > > +       rcu_read_unlock();
> >
> > Do we need to grab an additional reference for the audit container
> > object here?  We don't create any additional references here that
> > persist beyond the lifetime of this function, right?
>
> Why do we need another reference?  There's one for each pointer pointing
> to it and so far we have just one from this task.  Or are you thinking
> of the contid hash list, which is only added to when a task points to it
> and gets removed from that list when the last task stops pointing to it.
> Later that gets more complicated with network namespaces and nested
> container objects.  For now we just needed it while generating the
> record, then it gets freed.

I don't think we need to grab an additional reference here, that is
why I asked the question.  The code above grabs a reference for the
audit container ID object associated with the current task and then
drops it before returning; if the current task, and it's associated
audit container ID object, disappears in the middle of the function
we've got much bigger worries :)

-- 
paul moore
www.paul-moore.com
