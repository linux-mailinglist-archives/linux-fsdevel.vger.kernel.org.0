Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFCB3500CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 15:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhCaM7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 08:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbhCaM7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:59:20 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41180C061574;
        Wed, 31 Mar 2021 05:59:20 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d10so17081230ils.5;
        Wed, 31 Mar 2021 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyfZnB33bhI3RC435omT3TTPRISWi++RZeVVh2dbY4Q=;
        b=UD3qaCbScQgS33leQ/SUFx/nrEfrJLwRaNownvDD1ghgcHM4UfvXnsETNpNl2IRl/2
         WNVaM3kbwK1yKzgqgiVJrifPZtRmtX9POFKlgJcjOQYPXMdTmkAH6P0ZI3wSCXmtEKRJ
         7XuC5CSuU+NXLbbcjnCiErr7keCpp4sgwOBV/ba3Fj14GYiQtJjlNO2SRr9pplgLy0VA
         vKUh+4AGMgeTgeLEmVPd/cuomnf1V6V5qgOYN/uCJFVhhQm5aRkV8+bi0UfTK0ske3Rq
         Lx9djp0pMFjDBPVq1BxOQK3t55vch59kIJpC0tX66ZFdkC2JgFUEQ//0woFnwttFIn5x
         tIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyfZnB33bhI3RC435omT3TTPRISWi++RZeVVh2dbY4Q=;
        b=agfzpilEYBb+T03BC3RZ0FX+XQVU3WAiWl/5WeJH1ki/Xl4wf9ngN19oYMjutndhbM
         B4qJIbJyjsqurKSVRvnGL5WfNIkQDq/whtPUY0Yw9YQk+8YVyyW1wk7C52qI7ID5w0DL
         OmBvtz+L2VpwnnOEvOqUYQypoKSAvOUtO6kkEHif6R19kLQ9DCVQikAYl4CnSye5Et3u
         dK0ym2Q/61VrtOWg55SM3mlUI4y3e6I8dLtJHUrh4YU/THAh0emRRBmgynKi/eBhE/zI
         W9zXMhCpOZ2Ti6nimEwAkF2A8/KxiLjOIwTg5DwX1NyNo3Vl1d06WBq5rObHYyhp6Hae
         ucjA==
X-Gm-Message-State: AOAM530vqJNaFrIU/Uay6xaJF8dbJCAUqpO5YxvQisOLELkJqayvA7Aw
        R2O+ugIUv5/zWVPJcZQYLhVFiE8Bmc3WApG4GI1umZCQCTg=
X-Google-Smtp-Source: ABdhPJweb+MZu104Pe3/O9HTzVlMLEsvytITnCekCHI68YBCNHGD3m7296kTf52bOtfPO+j9sYojtD8vVf0KYt9ynGs=
X-Received: by 2002:a05:6e02:b2a:: with SMTP id e10mr2574175ilu.9.1617195559669;
 Wed, 31 Mar 2021 05:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein> <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331121719.adj2zk7yhjn3jfri@wittgenstein>
In-Reply-To: <20210331121719.adj2zk7yhjn3jfri@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 31 Mar 2021 15:59:08 +0300
Message-ID: <CAOQ4uxhebBjDssJWRS5vPcwG1N+3Tg_Tb1o4w_Wp+c9L-NhejA@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > This implementation is a compromise for not having clear user mount
> > context in all places that call for an event.
> > For every person you find that thinks it is intuitive to get an event on /B
> > for touch C/bla, you will find another person that thinks it is not intuitive
>
> And I think here we disagree. The technical implementation currently
> requires this since the two mounts are both clearly marked and the first
> mount creates objects by going through the other mount and they don't
> have a private mount. All I was saying is that the current patchset
> can't handle this case and asked whether we are ok with that and if not
> what we do to fix it.
> My proposal two or three mails ago and then picked up by you is: make
> them both use a private clone mount which is - as I said in earlier
> mails - the correct solution anyway and falls in line with overlayfs
> too.
>

As long as we agree on the solution ;-)

> > to get an event. I think we are way beyond the stage with mount
> > namespaces where intuition alone suffice.
> >
> > w.r.t consistent, you gave a few examples and I suggested how IMO
> > they should be fixed to behave consistently.
> > If you have other examples of alleged inconsistencies, please list them.
>
> It feels like I somehow upset you with this.

You do not upset me.

I just didn't find a better way to address "consistent and intuitive" concern
without asking for more concrete examples, after we eliminated the
ecryptfs example, which we already agreed(?), is a non issue.

My claim about "intuitive" is that there is a limit to how intuitive
this could be.
I do not see myself explaining in the man page why FAN_DELETE_SELF
cannot be requested for a mount mark. It's just too low level.

So the best I can do is document the events that are available to inode/sb
mark and not available to mount mark.

Currently, the fanotify_mark.2 man page reads:
"...The events which require that filesystem objects are identified by
file handles,
 such as FAN_CREATE, FAN_ATTRIB,  FAN_MOVE,  and FAN_DELETE_SELF,
 cannot  be provided as a mask when flags contains FAN_MARK_MOUNT..."

I will change that to:
"...The events FAN_ATTRIB,  FAN_MOVE,  and FAN_DELETE_SELF,
 cannot  be provided as a mask when flags contain FAN_MARK_MOUNT..."

Without providing a rationale to the list of forbidden events.

BTW, there is an undocumented fact about FAN_MODIFY -
This event is allowed in a mount mark mask, but it only reports the events
generated by fsnotify_modify() on file writes. It does not report to a mount
mark, the FAN_MODIFY event generated by fsnotify_change() from
truncate() and utimensat(), because of the missing mount context.

So yeh, I do understand where the "inconsistent" feeling is coming from... ;-)

[...]
> > So I would like to know that we really have all the pieces needed for
> > a useful solution, before proposing the fanotify patches.
>
> Sure, if you think that you have your branch in the shape that you want
> to. So far it has been evolving quite rapidly as you said yourself. :)
> I can probably test this soon early next week seems most likely since I
> need to find a timeslot to actually do the work you're asking. Hope that
> works.
>

No plans to make any more changes to those branches and no rush
as to when to post tham. This is not v4.13-rc1 material anyway.

Thanks,
Amir.
