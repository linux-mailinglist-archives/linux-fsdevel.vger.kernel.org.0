Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F52AF7A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfIKIUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 04:20:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36780 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfIKIUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:20:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id l20so19116238ljj.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2019 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+m9x3JWLhwIqvuMoxWRxqj3ba8FKSQ8O7LFTkMOLlew=;
        b=RRpTFHP5ueHajsvLMsI/iFfxjX5qsPmUHWdBM6bq0ow1L7Ed2oFyYa2eLvSgIzhJ3g
         ixTPAsqHegmHktTseJZNo6gOFG2sxzCTlDJphxT/tVXd4fzIJIdXv+TIbTmHCu2I6Hrr
         lCYGrAet2KFEdP1noMXMkJRAvGKlOYEqoJlYCjNYQfWC+yLF29A/NXyZvyn2VpMhh8BW
         eYcXZD5vqok0VNuRD9LH01+pxVL7HL2qulHHuSC1YCvWNu72xceghVAH3IY7VAXj/J7v
         5J2FwBxj4XrDmPdICdIQN5ZZVN8I3zG8k/Ql/cvJhAgkKVN3KzvrcaHtQGZOa985esml
         +B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+m9x3JWLhwIqvuMoxWRxqj3ba8FKSQ8O7LFTkMOLlew=;
        b=ZpYDojZo2pVZk/7ThAuJSujZj4iRXFAm4ZKiAmpMlfpALb9M+r1scjpp9ZGJ4O87ov
         GtVT+vmQTmjQTKg+l2PCvKhX4W+rDct+Uw86kEeY6tN0FJl/zmDTUMSBgeRsxjvlgxXv
         iMs3XTAiiPohycykYwSSBWYf7C4A9FrC/Xzret+3KbDnmBkA3Hup+blYIKNm4TFHTA0y
         6T10FnoOBSbi3YMSxU7SPtSvFpdbE8ZUtyhTcyS+1R46qKCgqdmEgLyb0MqskaRinXxC
         O/lVKjHvM6bMHs26+FEWKjg4jDX+EBOQGRYU31wF61BW/hoDTEXTGEreGk91frcP1JuR
         KXdQ==
X-Gm-Message-State: APjAAAWYazLRjE5Q4im6d908e4vY7FiL91Vr4hspKRjrbSOhgGIzBZmc
        lloex9a4nlcWJ+YFP8ltkndbulmBte9+tneSP8sWbA==
X-Google-Smtp-Source: APXvYqzVzVHTQhWsyIQN3LwLzPNTP76KqbkIxxkLyVdF3mWypoO5SJUnVmubqBDyc5tPwY/ljtlQ1GXQc8axjIaJDdE=
X-Received: by 2002:a2e:5dc3:: with SMTP id v64mr23550374lje.118.1568190014566;
 Wed, 11 Sep 2019 01:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190902052034.16423-1-r@hev.cc> <0cdc9905efb9b77b159e09bee17d3ad4@suse.de>
 <7075dd44-feea-a52f-ddaa-087d7bb2c4f6@akamai.com> <23659bc3e5f80efe9746aefd4d6791e8@suse.de>
 <341df9eb-7e8e-98c8-5183-402bdfff7d59@akamai.com> <CAHirt9hra2tA_OPNSow+CgD_CF2Z11ZqGG=1P45noqtdMtWuJw@mail.gmail.com>
 <CAHirt9j+DSR+uP-SBLHn0ika86uixSOPLXft+vVj5G5Ge0xr5w@mail.gmail.com>
 <CAHirt9iZAj67FVnhd9ORp2Sk2xAXHDrJ2BANf4VrtM4dLWv9ww@mail.gmail.com>
 <d5914273597707b8780d188688fe0ac2@suse.de> <6fd44437-fdd8-3be3-a2ef-6c3534d4e954@akamai.com>
In-Reply-To: <6fd44437-fdd8-3be3-a2ef-6c3534d4e954@akamai.com>
From:   Heiher <r@hev.cc>
Date:   Wed, 11 Sep 2019 16:19:56 +0800
Message-ID: <CAHirt9gtCssDsS6NjfxSociPObL6vwL7ygCWjgZZYegsUt4YOg@mail.gmail.com>
Subject: Re: [PATCH RESEND] fs/epoll: fix the edge-triggered mode for nested epoll
To:     Jason Baron <jbaron@akamai.com>
Cc:     Roman Penyaev <rpenyaev@suse.de>, linux-fsdevel@vger.kernel.org,
        Eric Wong <e@80x24.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, Sep 6, 2019 at 1:48 AM Jason Baron <jbaron@akamai.com> wrote:
>
>
>
> On 9/5/19 1:27 PM, Roman Penyaev wrote:
> > On 2019-09-05 11:56, Heiher wrote:
> >> Hi,
> >>
> >> On Thu, Sep 5, 2019 at 10:53 AM Heiher <r@hev.cc> wrote:
> >>>
> >>> Hi,
> >>>
> >>> I created an epoll wakeup test project, listed some possible cases,
> >>> and any other corner cases needs to be added?
> >>>
> >>> https://github.com/heiher/epoll-wakeup/blob/master/README.md
> >>>
> >>> On Wed, Sep 4, 2019 at 10:02 PM Heiher <r@hev.cc> wrote:
> >>> >
> >>> > Hi,
> >>> >
> >>> > On Wed, Sep 4, 2019 at 8:02 PM Jason Baron <jbaron@akamai.com> wrote:
> >>> > >
> >>> > >
> >>> > >
> >>> > > On 9/4/19 5:57 AM, Roman Penyaev wrote:
> >>> > > > On 2019-09-03 23:08, Jason Baron wrote:
> >>> > > >> On 9/2/19 11:36 AM, Roman Penyaev wrote:
> >>> > > >>> Hi,
> >>> > > >>>
> >>> > > >>> This is indeed a bug. (quick side note: could you please
> >>> remove efd[1]
> >>> > > >>> from your test, because it is not related to the reproduction
> >>> of a
> >>> > > >>> current bug).
> >>> > > >>>
> >>> > > >>> Your patch lacks a good description, what exactly you've
> >>> fixed.  Let
> >>> > > >>> me speak out loud and please correct me if I'm wrong, my
> >>> understanding
> >>> > > >>> of epoll internals has become a bit rusty: when epoll fds are
> >>> nested
> >>> > > >>> an attempt to harvest events (ep_scan_ready_list() call)
> >>> produces a
> >>> > > >>> second (repeated) event from an internal fd up to an external
> >>> fd:
> >>> > > >>>
> >>> > > >>>      epoll_wait(efd[0], ...):
> >>> > > >>>        ep_send_events():
> >>> > > >>>           ep_scan_ready_list(depth=0):
> >>> > > >>>             ep_send_events_proc():
> >>> > > >>>                 ep_item_poll():
> >>> > > >>>                   ep_scan_ready_list(depth=1):
> >>> > > >>>                     ep_poll_safewake():
> >>> > > >>>                       ep_poll_callback()
> >>> > > >>>                         list_add_tail(&epi, &epi->rdllist);
> >>> > > >>>                         ^^^^^^
> >>> > > >>>                         repeated event
> >>> > > >>>
> >>> > > >>>
> >>> > > >>> In your patch you forbid wakeup for the cases, where depth !=
> >>> 0, i.e.
> >>> > > >>> for all nested cases. That seems clear.  But what if we can
> >>> go further
> >>> > > >>> and remove the whole chunk, which seems excessive:
> >>> > > >>>
> >>> > > >>> @@ -885,26 +886,11 @@ static __poll_t ep_scan_ready_list(struct
> >>> > > >>> eventpoll *ep,
> >>> > > >>>
> >>> > > >>> -
> >>> > > >>> -       if (!list_empty(&ep->rdllist)) {
> >>> > > >>> -               /*
> >>> > > >>> -                * Wake up (if active) both the eventpoll
> >>> wait list and
> >>> > > >>> -                * the ->poll() wait list (delayed after we
> >>> release the
> >>> > > >>> lock).
> >>> > > >>> -                */
> >>> > > >>> -               if (waitqueue_active(&ep->wq))
> >>> > > >>> -                       wake_up(&ep->wq);
> >>> > > >>> -               if (waitqueue_active(&ep->poll_wait))
> >>> > > >>> -                       pwake++;
> >>> > > >>> -       }
> >>> > > >>>         write_unlock_irq(&ep->lock);
> >>> > > >>>
> >>> > > >>>         if (!ep_locked)
> >>> > > >>>                 mutex_unlock(&ep->mtx);
> >>> > > >>>
> >>> > > >>> -       /* We have to call this outside the lock */
> >>> > > >>> -       if (pwake)
> >>> > > >>> -               ep_poll_safewake(&ep->poll_wait);
> >>> > > >>>
> >>> > > >>>
> >>> > > >>> I reason like that: by the time we've reached the point of
> >>> scanning events
> >>> > > >>> for readiness all wakeups from ep_poll_callback have been
> >>> already fired and
> >>> > > >>> new events have been already accounted in ready list
> >>> (ep_poll_callback()
> >>> > > >>> calls
> >>> > > >>> the same ep_poll_safewake()). Here, frankly, I'm not 100%
> >>> sure and probably
> >>> > > >>> missing some corner cases.
> >>> > > >>>
> >>> > > >>> Thoughts?
> >>> > > >>
> >>> > > >> So the: 'wake_up(&ep->wq);' part, I think is about waking up
> >>> other
> >>> > > >> threads that may be in waiting in epoll_wait(). For example,
> >>> there may
> >>> > > >> be multiple threads doing epoll_wait() on the same epoll fd,
> >>> and the
> >>> > > >> logic above seems to say thread 1 may have processed say N
> >>> events and
> >>> > > >> now its going to to go off to work those, so let's wake up
> >>> thread 2 now
> >>> > > >> to handle the next chunk.
> >>> > > >
> >>> > > > Not quite. Thread which calls ep_scan_ready_list() processes
> >>> all the
> >>> > > > events, and while processing those, removes them one by one
> >>> from the
> >>> > > > ready list.  But if event mask is !0 and event belongs to
> >>> > > > Level Triggered Mode descriptor (let's say default mode) it
> >>> tails event
> >>> > > > again back to the list (because we are in level mode, so event
> >>> should
> >>> > > > be there).  So at the end of this traversing loop ready list is
> >>> likely
> >>> > > > not empty, and if so, wake up again is called for nested epoll
> >>> fds.
> >>> > > > But, those nested epoll fds should get already all the
> >>> notifications
> >>> > > > from the main event callback ep_poll_callback(), regardless any
> >>> thread
> >>> > > > which traverses events.
> >>> > > >
> >>> > > > I suppose this logic exists for decades, when Davide (the
> >>> author) was
> >>> > > > reshuffling the code here and there.
> >>> > > >
> >>> > > > But I do not feel confidence to state that this extra wakeup is
> >>> bogus,
> >>> > > > I just have a gut feeling that it looks excessive.
> >>> > >
> >>> > > Note that I was talking about the wakeup done on ep->wq not
> >>> ep->poll_wait.
> >>> > > The path that I'm concerned about is let's say that there are N
> >>> events
> >>> > > queued on the ready list. A thread that was woken up in
> >>> epoll_wait may
> >>> > > decide to only process say N/2 of then. Then it will call wakeup
> >>> on ep->wq
> >>> > > and this will wakeup another thread to process the remaining N/2.
> >>> Without
> >>> > > the wakeup, the original thread isn't going to process the events
> >>> until
> >>> > > it finishes with the original N/2 and gets back to epoll_wait().
> >>> So I'm not
> >>> > > sure how important that path is but I wanted to at least note the
> >>> change
> >>> > > here would impact that behavior.
> >>> > >
> >>> > > Thanks,
> >>> > >
> >>> > > -Jason
> >>> > >
> >>> > >
> >>> > > >
> >>> > > >> So I think removing all that even for the
> >>> > > >> depth 0 case is going to change some behavior here. So
> >>> perhaps, it
> >>> > > >> should be removed for all depths except for 0? And if so, it
> >>> may be
> >>> > > >> better to make 2 patches here to separate these changes.
> >>> > > >>
> >>> > > >> For the nested wakeups, I agree that the extra wakeups seem
> >>> unnecessary
> >>> > > >> and it may make sense to remove them for all depths. I don't
> >>> think the
> >>> > > >> nested epoll semantics are particularly well spelled out, and
> >>> afaict,
> >>> > > >> nested epoll() has behaved this way for quite some time. And
> >>> the current
> >>> > > >> behavior is not bad in the way that a missing wakeup or false
> >>> negative
> >>> > > >> would be.
> >>> > > >
> >>> > > > That's 100% true! For edge mode extra wake up is not a bug, not
> >>> optimal
> >>> > > > for userspace - yes, but that can't lead to any lost wakeups.
> >>> > > >
> >>> > > > --
> >>> > > > Roman
> >>> > > >
> >>> >
> >>> > I tried to remove the whole chunk of code that Roman said, and it
> >>> > seems that there
> >>> > are no obvious problems with the two test programs below:
> >>
> >> I recall this message, the test case 9/25/26 of epoll-wakeup (on
> >> github) are failed while
> >> the whole chunk are removed.
> >>
> >> Apply the original patch, all tests passed.
> >
> >
> > These are failing on my bare 5.2.0-rc2
> >
> > TEST  bin/epoll31       FAIL
> > TEST  bin/epoll46       FAIL
> > TEST  bin/epoll50       FAIL
> > TEST  bin/epoll32       FAIL
> > TEST  bin/epoll19       FAIL
> > TEST  bin/epoll27       FAIL
> > TEST  bin/epoll42       FAIL
> > TEST  bin/epoll34       FAIL
> > TEST  bin/epoll48       FAIL
> > TEST  bin/epoll40       FAIL
> > TEST  bin/epoll20       FAIL
> > TEST  bin/epoll28       FAIL
> > TEST  bin/epoll38       FAIL
> > TEST  bin/epoll52       FAIL
> > TEST  bin/epoll24       FAIL
> > TEST  bin/epoll23       FAIL
> >
> >
> > These are failing if your patch is applied:
> > (my 5.2.0-rc2 is old? broken?)
> >
> > TEST  bin/epoll46       FAIL
> > TEST  bin/epoll42       FAIL
> > TEST  bin/epoll34       FAIL
> > TEST  bin/epoll48       FAIL
> > TEST  bin/epoll40       FAIL
> > TEST  bin/epoll44       FAIL
> > TEST  bin/epoll38       FAIL
> >
> > These are failing if "ep_poll_safewake(&ep->poll_wait)" is not called,
> > but wakeup(&ep->wq); is still invoked:
> >
> > TEST  bin/epoll46       FAIL
> > TEST  bin/epoll42       FAIL
> > TEST  bin/epoll34       FAIL
> > TEST  bin/epoll40       FAIL
> > TEST  bin/epoll44       FAIL
> > TEST  bin/epoll38       FAIL
> >
> > So at least 48 has been "fixed".
> >
> > These are failing if the whole chunk is removed, like your
> > said 9,25,26 are among which do not pass:
> >
> > TEST  bin/epoll26       FAIL
> > TEST  bin/epoll42       FAIL
> > TEST  bin/epoll34       FAIL
> > TEST  bin/epoll9        FAIL
> > TEST  bin/epoll48       FAIL
> > TEST  bin/epoll40       FAIL
> > TEST  bin/epoll25       FAIL
> > TEST  bin/epoll44       FAIL
> > TEST  bin/epoll38       FAIL
> >
> > This can be a good test suite, probably can be added to kselftests?

Thank you, I have updated epoll-tests to fix these issues. I think this is good
news if we can added to kselftests. ;)

> >
> > --
> > Roman
> >
>
>
> Indeed, I just tried the same test suite and I am seeing similar
> failures - it looks like its a bit timing dependent. It looks like all
> the failures are caused by a similar issue. For example, take epoll34:
>
>          t0   t1
>      (ew) |    | (ew)
>          e0    |
>       (lt) \  /
>              |
>             e1
>              | (et)
>             s0
>
>
> The test is trying to assert that an epoll_wait() on e1 and and
> epoll_wait() on e0 both return 1 event for EPOLLIN. However, the
> epoll_wait on e1 is done in a thread and it can happen before or after
> the epoll_wait() is called against e0. If the epoll_wait() on e1 happens
> first then because its attached as 'et', it consumes the event. So that
> there is no longer an event reported at e0. I think that is reasonable
> semantics here. However if the wait on e0 happens after the wait on e1
> then the test will pass as both waits will see the event. Thus, a patch
> like this will 'fix' this testcase:
>
> --- a/src/epoll34.c
> +++ b/src/epoll34.c
> @@ -59,15 +59,15 @@ int main(int argc, char *argv[])
>         if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
>                 goto out;
>
> -       if (pthread_create(&tw, NULL, thread_handler, NULL) < 0)
> -               goto out;
> -
>         if (pthread_create(&te, NULL, emit_handler, NULL) < 0)
>                 goto out;
>
>         if (epoll_wait(efd[0], &e, 1, 500) == 1)
>                 count++;
>
> +       if (pthread_create(&tw, NULL, thread_handler, NULL) < 0)
> +               goto out;
> +
>         if (pthread_join(tw, NULL) < 0)
>                 goto out;
>
>
> I found all the other failures to be of similar origin. I suspect Heiher
> didn't see failures due to the thread timings here.

Thank you. I also found a multi-threaded concurrent accumulation problem,
and that has been changed to atomic operations. I think we should allow two
different behaviors to be passed because they are all correctly.

thread 2:
if (epoll_wait(efd[1], &e, 1, 500) == 1)
    __sync_fetch_and_or(&count, 1);

thread1:
if (epoll_wait(efd[0], &e, 1, 500) == 1)
    __sync_fetch_and_or(&count, 2);

check:
if ((count != 1) && (count != 3))
    goto out;

>
> I also found that all the testcases pass if we leave the wakeup(&ep->wq)
> call for the depth 0 case (and remove the pwake part).

So, We need to keep the wakeup(&ep-wq) for all depth, and only
wakeup(&ep->poll_wait)
for depth 0 and/or ep->rdlist from empty to be not empty?

>
> Thanks,
>
> -Jason
>
>
>
>


-- 
Best regards!
Hev
https://hev.cc
