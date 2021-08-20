Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0950F3F2D00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbhHTNSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 09:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240614AbhHTNSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629465475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wpck0e8AqvXN86BNbpcERlh1fNBjt0D/mM/a3eVJMzI=;
        b=iPC+wmEWKYNEDPB2w58ETaypD/OXqHNiUs2nm74pHgd0JoHWN2SW5Ojs4xY4LHl8DfJ0Xx
        cwG1inSDh9Ksa2g/63yv+F3XVFL7e7Cq2EEFyWAgwm1KNIwtPVAF77gA08y12Fy/LQ+Hfo
        v5Cc159anMb0fN5tfRh6PeOoH6PgylE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-6cEPYUYUNwu5M0r6fHitoQ-1; Fri, 20 Aug 2021 09:17:54 -0400
X-MC-Unique: 6cEPYUYUNwu5M0r6fHitoQ-1
Received: by mail-wm1-f71.google.com with SMTP id 201-20020a1c01d2000000b002e72ba822dcso464883wmb.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 06:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wpck0e8AqvXN86BNbpcERlh1fNBjt0D/mM/a3eVJMzI=;
        b=dSCd+3RDj6M6BxbRfjtJibvmGz2iZSlzPCfhZKHm08uRnnO4sTjIUt2FZhOD5enVf5
         ahDuEpRVI1/R3zf4+RTvr8mcrXU/zGYT8k6PNNYh0ad3uzJaQfMb5MB5YAjJP9/21Fm5
         uGWQj17If5k0+yQmkSS6rkR3c6owoiMPSjeSA5OYy3s2U1BcIIbU760MmzYyPojd8t1Z
         xDPSnRwjEPEmP18hA1UOeyuKGgVSLp5lWE7edUQi6BbDSzZJJHl0RpVpUJbKjvbh8tmA
         KubWyhFmbnIlbk56cX4EIXP+RY3zW3DqE6WG3HueDfFEcXCcRq2zMAzmTsmVpFT6L5NF
         M3sQ==
X-Gm-Message-State: AOAM531pZFe9bVk8w6kW8nxjJ3rxpLF3eAVdeNp6HQh3wD9kJGtlzfKg
        NTuI9SVSzJA7PxYhRSUNDduFHhvDd05tYeYRDSXbrbdtwQ+Brgz3f+RfFPAzEdcNQN4CiRc0/bU
        ajubdr16i94eVfvhMKpEjpoJiLM+XHyqKKh4y41aD7A==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr10096059wrw.357.1629465473215;
        Fri, 20 Aug 2021 06:17:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaOj+xRpqTpCdRjBBMNYLIqX6obx5Qu7XAobp4tWowOF1CcguAZLMCq7dGTX+CKrCDIZyxQlBbYLfqGWiDMk0=
X-Received: by 2002:a5d:674b:: with SMTP id l11mr10095989wrw.357.1629465472672;
 Fri, 20 Aug 2021 06:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210819194102.1491495-1-agruenba@redhat.com> <20210819194102.1491495-11-agruenba@redhat.com>
 <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
In-Reply-To: <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 20 Aug 2021 15:17:41 +0200
Message-ID: <CAHc6FU7jz9z9FEu3gY0S2A2Rv6cQJzp7p_5NOnU3b8Zpz+QsVg@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 11:35 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
> On Thu, 2021-08-19 at 21:40 +0200, Andreas Gruenbacher wrote:
> > From: Bob Peterson <rpeterso@redhat.com>
> >
> > This patch introduces a new HIF_MAY_DEMOTE flag and infrastructure
> > that will allow glocks to be demoted automatically on locking conflicts.
> > When a locking request comes in that isn't compatible with the locking
> > state of a holder and that holder has the HIF_MAY_DEMOTE flag set, the
> > holder will be demoted automatically before the incoming locking request
> > is granted.
>
> I'm not sure I understand what is going on here. When there are locking
> conflicts we generate call backs and those result in glock demotion.
> There is no need for a flag to indicate that I think, since it is the
> default behaviour anyway. Or perhaps the explanation is just a bit
> confusing...

When a glock has active holders (with the HIF_HOLDER flag set), the
glock won't be demoted to a state incompatible with any of those
holders.

> > Processes that allow a glock holder to be taken away indicate this by
> > calling gfs2_holder_allow_demote().  When they need the glock again,
> > they call gfs2_holder_disallow_demote() and then they check if the
> > holder is still queued: if it is, they're still holding the glock; if
> > it isn't, they need to re-acquire the glock.
> >
> > This allows processes to hang on to locks that could become part of a
> > cyclic locking dependency.  The locks will be given up when a (rare)
> > conflicting locking request occurs, and don't need to be given up
> > prematurely.
>
> This seems backwards to me. We already have the glock layer cache the
> locks until they are required by another node. We also have the min
> hold time to make sure that we don't bounce locks too much. So what is
> the problem that you are trying to solve here I wonder?

This solves the problem of faulting in pages during read and write
operations: on the one hand, we want to hold the inode glock across
those operations. On the other hand, those operations may fault in
pages, which may require taking the same or other inode glocks,
directly or indirectly, which can deadlock.

So before we fault in pages, we indicate with
gfs2_holder_allow_demote(gh) that we can cope if the glock is taken
away from us. After faulting in the pages, we indicate with
gfs2_holder_disallow_demote(gh) that we now actually need the glock
again. At that point, we either still have the glock (i.e., the holder
is still queued and it has the HIF_HOLDER flag set), or we don't.

The different kinds of read and write operations differ in how they
handle the latter case:

 * When a buffered read or write loses the inode glock, it returns a
short result. This
   prevents torn writes and reading things that have never existed on
disk in that form.

 * When a direct read or write loses the inode glock, it re-acquires
it before resuming
   the operation. Direct I/O is not expected to return partial results
and doesn't provide
   any kind of synchronization among processes.

We could solve this kind of problem in other ways, for example, by
keeping a glock generation number, dropping the glock before faulting
in pages, re-acquiring it afterwards, and checking if the generation
number has changed. This would still be an additional piece of glock
infrastructure, but more heavyweight than the HIF_MAY_DEMOTE flag
which uses the existing glock holder infrastructure.

> > Signed-off-by: Bob Peterson <rpeterso@redhat.com>
> > ---
> >  fs/gfs2/glock.c  | 221 +++++++++++++++++++++++++++++++++++++++----
> > ----
> >  fs/gfs2/glock.h  |  20 +++++
> >  fs/gfs2/incore.h |   1 +
> >  3 files changed, 206 insertions(+), 36 deletions(-)
> >
> > diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
> > index f24db2ececfb..d1b06a09ce2f 100644
> > --- a/fs/gfs2/glock.c
> > +++ b/fs/gfs2/glock.c
> > @@ -58,6 +58,7 @@ struct gfs2_glock_iter {
> >  typedef void (*glock_examiner) (struct gfs2_glock * gl);
> >
> >  static void do_xmote(struct gfs2_glock *gl, struct gfs2_holder *gh,
> > unsigned int target);
> > +static void __gfs2_glock_dq(struct gfs2_holder *gh);
> >
> >  static struct dentry *gfs2_root;
> >  static struct workqueue_struct *glock_workqueue;
> > @@ -197,6 +198,12 @@ static int demote_ok(const struct gfs2_glock
> > *gl)
> >
> >       if (gl->gl_state == LM_ST_UNLOCKED)
> >               return 0;
> > +     /*
> > +      * Note that demote_ok is used for the lru process of disposing
> > of
> > +      * glocks. For this purpose, we don't care if the glock's
> > holders
> > +      * have the HIF_MAY_DEMOTE flag set or not. If someone is using
> > +      * them, don't demote.
> > +      */
> >       if (!list_empty(&gl->gl_holders))
> >               return 0;
> >       if (glops->go_demote_ok)
> > @@ -379,7 +386,7 @@ static void do_error(struct gfs2_glock *gl, const
> > int ret)
> >       struct gfs2_holder *gh, *tmp;
> >
> >       list_for_each_entry_safe(gh, tmp, &gl->gl_holders, gh_list) {
> > -             if (test_bit(HIF_HOLDER, &gh->gh_iflags))
> > +             if (!test_bit(HIF_WAIT, &gh->gh_iflags))
> >                       continue;
> >               if (ret & LM_OUT_ERROR)
> >                       gh->gh_error = -EIO;
> > @@ -393,6 +400,40 @@ static void do_error(struct gfs2_glock *gl,
> > const int ret)
> >       }
> >  }
> >
> > +/**
> > + * demote_incompat_holders - demote incompatible demoteable holders
> > + * @gl: the glock we want to promote
> > + * @new_gh: the new holder to be promoted
> > + */
> > +static void demote_incompat_holders(struct gfs2_glock *gl,
> > +                                 struct gfs2_holder *new_gh)
> > +{
> > +     struct gfs2_holder *gh;
> > +
> > +     /*
> > +      * Demote incompatible holders before we make ourselves
> > eligible.
> > +      * (This holder may or may not allow auto-demoting, but we
> > don't want
> > +      * to demote the new holder before it's even granted.)
> > +      */
> > +     list_for_each_entry(gh, &gl->gl_holders, gh_list) {
> > +             /*
> > +              * Since holders are at the front of the list, we stop
> > when we
> > +              * find the first non-holder.
> > +              */
> > +             if (!test_bit(HIF_HOLDER, &gh->gh_iflags))
> > +                     return;
> > +             if (test_bit(HIF_MAY_DEMOTE, &gh->gh_iflags) &&
> > +                 !may_grant(gl, new_gh, gh)) {
> > +                     /*
> > +                      * We should not recurse into do_promote
> > because
> > +                      * __gfs2_glock_dq only calls handle_callback,
> > +                      * gfs2_glock_add_to_lru and
> > __gfs2_glock_queue_work.
> > +                      */
> > +                     __gfs2_glock_dq(gh);
> > +             }
> > +     }
> > +}
> > +
> >  /**
> >   * find_first_holder - find the first "holder" gh
> >   * @gl: the glock
> > @@ -411,6 +452,26 @@ static inline struct gfs2_holder
> > *find_first_holder(const struct gfs2_glock *gl)
> >       return NULL;
> >  }
> >
> > +/**
> > + * find_first_strong_holder - find the first non-demoteable holder
> > + * @gl: the glock
> > + *
> > + * Find the first holder that doesn't have the HIF_MAY_DEMOTE flag
> > set.
> > + */
> > +static inline struct gfs2_holder
> > +*find_first_strong_holder(struct gfs2_glock *gl)
> > +{
> > +     struct gfs2_holder *gh;
> > +
> > +     list_for_each_entry(gh, &gl->gl_holders, gh_list) {
> > +             if (!test_bit(HIF_HOLDER, &gh->gh_iflags))
> > +                     return NULL;
> > +             if (!test_bit(HIF_MAY_DEMOTE, &gh->gh_iflags))
> > +                     return gh;
> > +     }
> > +     return NULL;
> > +}
> > +
> >  /**
> >   * do_promote - promote as many requests as possible on the current
> > queue
> >   * @gl: The glock
> > @@ -425,15 +486,27 @@ __acquires(&gl->gl_lockref.lock)
> >  {
> >       const struct gfs2_glock_operations *glops = gl->gl_ops;
> >       struct gfs2_holder *gh, *tmp, *first_gh;
> > +     bool incompat_holders_demoted = false;
> >       int ret;
> >
> > -     first_gh = find_first_holder(gl);
> > +     first_gh = find_first_strong_holder(gl);
> >
> >  restart:
> >       list_for_each_entry_safe(gh, tmp, &gl->gl_holders, gh_list) {
> > -             if (test_bit(HIF_HOLDER, &gh->gh_iflags))
> > +             if (!test_bit(HIF_WAIT, &gh->gh_iflags))
> >                       continue;
> >               if (may_grant(gl, first_gh, gh)) {
> > +                     if (!incompat_holders_demoted) {
> > +                             demote_incompat_holders(gl, first_gh);
> > +                             incompat_holders_demoted = true;
> > +                             first_gh = gh;
> > +                     }
> > +                     /*
> > +                      * The first holder (and only the first holder)
> > on the
> > +                      * list to be promoted needs to call the
> > go_lock
> > +                      * function. This does things like
> > inode_refresh
> > +                      * to read an inode from disk.
> > +                      */
> >                       if (gh->gh_list.prev == &gl->gl_holders &&
> >                           glops->go_lock) {
> >                               spin_unlock(&gl->gl_lockref.lock);
> > @@ -459,6 +532,11 @@ __acquires(&gl->gl_lockref.lock)
> >                       gfs2_holder_wake(gh);
> >                       continue;
> >               }
> > +             /*
> > +              * If we get here, it means we may not grant this
> > holder for
> > +              * some reason. If this holder is the head of the list,
> > it
> > +              * means we have a blocked holder at the head, so
> > return 1.
> > +              */
> >               if (gh->gh_list.prev == &gl->gl_holders)
> >                       return 1;
> >               do_error(gl, 0);
> > @@ -1373,7 +1451,7 @@ __acquires(&gl->gl_lockref.lock)
> >               if (test_bit(GLF_LOCK, &gl->gl_flags)) {
> >                       struct gfs2_holder *first_gh;
> >
> > -                     first_gh = find_first_holder(gl);
> > +                     first_gh = find_first_strong_holder(gl);
> >                       try_futile = !may_grant(gl, first_gh, gh);
> >               }
> >               if (test_bit(GLF_INVALIDATE_IN_PROGRESS, &gl-
> > >gl_flags))
> > @@ -1382,7 +1460,8 @@ __acquires(&gl->gl_lockref.lock)
> >
> >       list_for_each_entry(gh2, &gl->gl_holders, gh_list) {
> >               if (unlikely(gh2->gh_owner_pid == gh->gh_owner_pid &&
> > -                 (gh->gh_gl->gl_ops->go_type != LM_TYPE_FLOCK)))
> > +                 (gh->gh_gl->gl_ops->go_type != LM_TYPE_FLOCK) &&
> > +                 !test_bit(HIF_MAY_DEMOTE, &gh2->gh_iflags)))
> >                       goto trap_recursive;
> >               if (try_futile &&
> >                   !(gh2->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)))
> > {
> > @@ -1478,51 +1557,83 @@ int gfs2_glock_poll(struct gfs2_holder *gh)
> >       return test_bit(HIF_WAIT, &gh->gh_iflags) ? 0 : 1;
> >  }
> >
> > -/**
> > - * gfs2_glock_dq - dequeue a struct gfs2_holder from a glock
> > (release a glock)
> > - * @gh: the glock holder
> > - *
> > - */
> > +static inline bool needs_demote(struct gfs2_glock *gl)
> > +{
> > +     return (test_bit(GLF_DEMOTE, &gl->gl_flags) ||
> > +             test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags));
> > +}
> >
> > -void gfs2_glock_dq(struct gfs2_holder *gh)
> > +static void __gfs2_glock_dq(struct gfs2_holder *gh)
> >  {
> >       struct gfs2_glock *gl = gh->gh_gl;
> >       struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
> >       unsigned delay = 0;
> >       int fast_path = 0;
> >
> > -     spin_lock(&gl->gl_lockref.lock);
> >       /*
> > -      * If we're in the process of file system withdraw, we cannot
> > just
> > -      * dequeue any glocks until our journal is recovered, lest we
> > -      * introduce file system corruption. We need two exceptions to
> > this
> > -      * rule: We need to allow unlocking of nondisk glocks and the
> > glock
> > -      * for our own journal that needs recovery.
> > +      * This while loop is similar to function
> > demote_incompat_holders:
> > +      * If the glock is due to be demoted (which may be from another
> > node
> > +      * or even if this holder is GL_NOCACHE), the weak holders are
> > +      * demoted as well, allowing the glock to be demoted.
> >        */
> > -     if (test_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags) &&
> > -         glock_blocked_by_withdraw(gl) &&
> > -         gh->gh_gl != sdp->sd_jinode_gl) {
> > -             sdp->sd_glock_dqs_held++;
> > -             spin_unlock(&gl->gl_lockref.lock);
> > -             might_sleep();
> > -             wait_on_bit(&sdp->sd_flags, SDF_WITHDRAW_RECOVERY,
> > -                         TASK_UNINTERRUPTIBLE);
> > -             spin_lock(&gl->gl_lockref.lock);
> > -     }
> > -     if (gh->gh_flags & GL_NOCACHE)
> > -             handle_callback(gl, LM_ST_UNLOCKED, 0, false);
> > +     while (gh) {
> > +             /*
> > +              * If we're in the process of file system withdraw, we
> > cannot
> > +              * just dequeue any glocks until our journal is
> > recovered, lest
> > +              * we introduce file system corruption. We need two
> > exceptions
> > +              * to this rule: We need to allow unlocking of nondisk
> > glocks
> > +              * and the glock for our own journal that needs
> > recovery.
> > +              */
> > +             if (test_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags) &&
> > +                 glock_blocked_by_withdraw(gl) &&
> > +                 gh->gh_gl != sdp->sd_jinode_gl) {
> > +                     sdp->sd_glock_dqs_held++;
> > +                     spin_unlock(&gl->gl_lockref.lock);
> > +                     might_sleep();
> > +                     wait_on_bit(&sdp->sd_flags,
> > SDF_WITHDRAW_RECOVERY,
> > +                                 TASK_UNINTERRUPTIBLE);
> > +                     spin_lock(&gl->gl_lockref.lock);
> > +             }
> > +
> > +             /*
> > +              * This holder should not be cached, so mark it for
> > demote.
> > +              * Note: this should be done before the check for
> > needs_demote
> > +              * below.
> > +              */
> > +             if (gh->gh_flags & GL_NOCACHE)
> > +                     handle_callback(gl, LM_ST_UNLOCKED, 0, false);
> >
> > -     list_del_init(&gh->gh_list);
> > -     clear_bit(HIF_HOLDER, &gh->gh_iflags);
> > -     if (list_empty(&gl->gl_holders) &&
> > -         !test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
> > -         !test_bit(GLF_DEMOTE, &gl->gl_flags))
> > -             fast_path = 1;
> > +             list_del_init(&gh->gh_list);
> > +             clear_bit(HIF_HOLDER, &gh->gh_iflags);
> > +             trace_gfs2_glock_queue(gh, 0);
> > +
> > +             /*
> > +              * If there hasn't been a demote request we are done.
> > +              * (Let the remaining holders, if any, keep holding
> > it.)
> > +              */
> > +             if (!needs_demote(gl)) {
> > +                     if (list_empty(&gl->gl_holders))
> > +                             fast_path = 1;
> > +                     break;
> > +             }
> > +             /*
> > +              * If we have another strong holder (we cannot auto-
> > demote)
> > +              * we are done. It keeps holding it until it is done.
> > +              */
> > +             if (find_first_strong_holder(gl))
> > +                     break;
> > +
> > +             /*
> > +              * If we have a weak holder at the head of the list, it
> > +              * (and all others like it) must be auto-demoted. If
> > there
> > +              * are no more weak holders, we exit the while loop.
> > +              */
> > +             gh = find_first_holder(gl);
> > +     }
> >
> >       if (!test_bit(GLF_LFLUSH, &gl->gl_flags) && demote_ok(gl))
> >               gfs2_glock_add_to_lru(gl);
> >
> > -     trace_gfs2_glock_queue(gh, 0);
> >       if (unlikely(!fast_path)) {
> >               gl->gl_lockref.count++;
> >               if (test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
> > @@ -1531,6 +1642,19 @@ void gfs2_glock_dq(struct gfs2_holder *gh)
> >                       delay = gl->gl_hold_time;
> >               __gfs2_glock_queue_work(gl, delay);
> >       }
> > +}
> > +
> > +/**
> > + * gfs2_glock_dq - dequeue a struct gfs2_holder from a glock
> > (release a glock)
> > + * @gh: the glock holder
> > + *
> > + */
> > +void gfs2_glock_dq(struct gfs2_holder *gh)
> > +{
> > +     struct gfs2_glock *gl = gh->gh_gl;
> > +
> > +     spin_lock(&gl->gl_lockref.lock);
> > +     __gfs2_glock_dq(gh);
> >       spin_unlock(&gl->gl_lockref.lock);
> >  }
> >
> > @@ -1693,6 +1817,7 @@ void gfs2_glock_dq_m(unsigned int num_gh,
> > struct gfs2_holder *ghs)
> >
> >  void gfs2_glock_cb(struct gfs2_glock *gl, unsigned int state)
> >  {
> > +     struct gfs2_holder mock_gh = { .gh_gl = gl, .gh_state = state,
> > };
> >       unsigned long delay = 0;
> >       unsigned long holdtime;
> >       unsigned long now = jiffies;
> > @@ -1707,6 +1832,28 @@ void gfs2_glock_cb(struct gfs2_glock *gl,
> > unsigned int state)
> >               if (test_bit(GLF_REPLY_PENDING, &gl->gl_flags))
> >                       delay = gl->gl_hold_time;
> >       }
> > +     /*
> > +      * Note 1: We cannot call demote_incompat_holders from
> > handle_callback
> > +      * or gfs2_set_demote due to recursion problems like:
> > gfs2_glock_dq ->
> > +      * handle_callback -> demote_incompat_holders -> gfs2_glock_dq
> > +      * Plus, we only want to demote the holders if the request
> > comes from
> > +      * a remote cluster node because local holder conflicts are
> > resolved
> > +      * elsewhere.
> > +      *
> > +      * Note 2: if a remote node wants this glock in EX mode,
> > lock_dlm will
> > +      * request that we set our state to UNLOCKED. Here we mock up a
> > holder
> > +      * to make it look like someone wants the lock EX locally. Any
> > SH
> > +      * and DF requests should be able to share the lock without
> > demoting.
> > +      *
> > +      * Note 3: We only want to demote the demoteable holders when
> > there
> > +      * are no more strong holders. The demoteable holders might as
> > well
> > +      * keep the glock until the last strong holder is done with it.
> > +      */
> > +     if (!find_first_strong_holder(gl)) {
> > +             if (state == LM_ST_UNLOCKED)
> > +                     mock_gh.gh_state = LM_ST_EXCLUSIVE;
> > +             demote_incompat_holders(gl, &mock_gh);
> > +     }
> >       handle_callback(gl, state, delay, true);
> >       __gfs2_glock_queue_work(gl, delay);
> >       spin_unlock(&gl->gl_lockref.lock);
> > @@ -2096,6 +2243,8 @@ static const char *hflags2str(char *buf, u16
> > flags, unsigned long iflags)
> >               *p++ = 'H';
> >       if (test_bit(HIF_WAIT, &iflags))
> >               *p++ = 'W';
> > +     if (test_bit(HIF_MAY_DEMOTE, &iflags))
> > +             *p++ = 'D';
> >       *p = 0;
> >       return buf;
> >  }
> > diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
> > index 31a8f2f649b5..9012487da4c6 100644
> > --- a/fs/gfs2/glock.h
> > +++ b/fs/gfs2/glock.h
> > @@ -150,6 +150,8 @@ static inline struct gfs2_holder
> > *gfs2_glock_is_locked_by_me(struct gfs2_glock *
> >       list_for_each_entry(gh, &gl->gl_holders, gh_list) {
> >               if (!test_bit(HIF_HOLDER, &gh->gh_iflags))
> >                       break;
> > +             if (test_bit(HIF_MAY_DEMOTE, &gh->gh_iflags))
> > +                     continue;
> >               if (gh->gh_owner_pid == pid)
> >                       goto out;
> >       }
> > @@ -325,6 +327,24 @@ static inline void glock_clear_object(struct
> > gfs2_glock *gl, void *object)
> >       spin_unlock(&gl->gl_lockref.lock);
> >  }
> >
> > +static inline void gfs2_holder_allow_demote(struct gfs2_holder *gh)
> > +{
> > +     struct gfs2_glock *gl = gh->gh_gl;
> > +
> > +     spin_lock(&gl->gl_lockref.lock);
> > +     set_bit(HIF_MAY_DEMOTE, &gh->gh_iflags);
> > +     spin_unlock(&gl->gl_lockref.lock);
> > +}
> > +
> > +static inline void gfs2_holder_disallow_demote(struct gfs2_holder
> > *gh)
> > +{
> > +     struct gfs2_glock *gl = gh->gh_gl;
> > +
> > +     spin_lock(&gl->gl_lockref.lock);
> > +     clear_bit(HIF_MAY_DEMOTE, &gh->gh_iflags);
> > +     spin_unlock(&gl->gl_lockref.lock);
> > +}
> > +
>
> This looks a bit strange... bit operations are atomic anyway, so why do
> we need that spinlock here?

This is about making sure that the glock state engine will make
consistent decisions. Currently, those decisions are made under that
spin lock. We could set the HIF_MAY_DEMOTE flag followed by a memory
barrier and the glock state engine would *probably* still make the
right decisions most of the time, but that's not easy to ensure
anymore.

We surely want to prevent the glock state engine from making changes
while clearing the flag, though.

> Steve.
>
> >  extern void gfs2_inode_remember_delete(struct gfs2_glock *gl, u64
> > generation);
> >  extern bool gfs2_inode_already_deleted(struct gfs2_glock *gl, u64
> > generation);
> >
> > diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
> > index 5c6b985254aa..e73a81db0714 100644
> > --- a/fs/gfs2/incore.h
> > +++ b/fs/gfs2/incore.h
> > @@ -252,6 +252,7 @@ struct gfs2_lkstats {
> >
> >  enum {
> >       /* States */
> > +     HIF_MAY_DEMOTE          = 1,
> >       HIF_HOLDER              = 6,  /* Set for gh that "holds" the
> > glock */
> >       HIF_WAIT                = 10,
> >  };
>

Thanks,
Andreas

