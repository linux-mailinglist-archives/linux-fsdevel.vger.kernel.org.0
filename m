Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1967898D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjAWVaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 16:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjAWVaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:30:13 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E36126FF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 13:30:11 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k13so12840086plg.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 13:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3CXjuIq+evsfgA3IK+fUzmMcrAKyki1aZvq33cby3Hw=;
        b=PrhBAQsJ8QVyf7PeldKMnDrqvqSWRERblwTNL7klfEj/XuIcxUo3ZcuxnH7Kve8zim
         X3L4+P5505xaUSoE80Pok3PHOwJAYuAoIqxeToF2f6JuwiuX33a8bNHxsRQwKvAAi744
         hBzblxYOJt+8BBGSCCiypXmATdXv2kVBmOglwoXcYBg9x2ktg2JUUjI553mWya2s4FOc
         C8vLzcVIVflGtPF03e/unFkWEj3LRhoeKftUgVFIQ/E3r3bOd+3qQEruu4YXM0Ppp2Ck
         2XcgQDrZ0OQ6+CLjNCplGDe13tC1itgncilQAAJ6KM71kiV5XAGO6mWOMXAZ6xAB3Vaf
         zOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CXjuIq+evsfgA3IK+fUzmMcrAKyki1aZvq33cby3Hw=;
        b=h6A5qAxp2ozTtGan3fBrfZZN39an6qG8O/cpgDFH1b/gOhRgnkVuYP0ue/HvQF7lqF
         gHqjbIkxwBX4/h94mG4UXPweEwIgSoKTT7V848LDaWhW7q2/guqX6T0ETz2+fmEi8rYe
         YbJxNYBxBWAq26wchUOl39rTsJgon02wvZqLZz9gdxsckrt+xmhVKBnzJlaZocpWdhg3
         b21IJIz18M1x84nbatdKnySNJRSWV4cmdA6RbQXoPMtpapfsVKhgqBwAR8FnV6n66yAY
         U5OvqJB30CeTC+r5mcshduiibuRLSkUPHGzSSGxxGDPvM/41ewjFPDDCj90bvxMHTRRZ
         PNDw==
X-Gm-Message-State: AFqh2kqE8+rQrzGE26LnhRuSYXhdowxgSfkRLezOLqrC1/AAfWYIkQbf
        coEwYVmKhACS3AbFYANKzy9lH5bGgd6+7SU3aF7y
X-Google-Smtp-Source: AMrXdXt6nnp1chN91l/keRi65PeLkFLfyDMkNuj5KKKeJZ/tAe4Ffdk/DaqnXAbK3nVyNifZ5DN6P4wh53FYOPNX5XM=
X-Received: by 2002:a17:90a:17a1:b0:229:9ffe:135b with SMTP id
 q30-20020a17090a17a100b002299ffe135bmr2908716pja.72.1674509410794; Mon, 23
 Jan 2023 13:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com> <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
In-Reply-To: <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Jan 2023 16:29:59 -0500
Message-ID: <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, serge@hallyn.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 7:50 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> On 1/20/23, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Jan 16, 2023 at 4:21 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >>
> >> access(2) remains commonly used, for example on exec:
> >> access("/etc/ld.so.preload", R_OK)
> >>
> >> or when running gcc: strace -c gcc empty.c
> >> % time     seconds  usecs/call     calls    errors syscall
> >> ------ ----------- ----------- --------- --------- ----------------
> >>   0.00    0.000000           0        42        26 access
> >>
> >> It falls down to do_faccessat without the AT_EACCESS flag, which in turn
> >> results in allocation of new creds in order to modify fsuid/fsgid and
> >> caps. This is a very expensive process single-threaded and most notably
> >> multi-threaded, with numerous structures getting refed and unrefed on
> >> imminent new cred destruction.
> >>
> >> Turns out for typical consumers the resulting creds would be identical
> >> and this can be checked upfront, avoiding the hard work.
> >>
> >> An access benchmark plugged into will-it-scale running on Cascade Lake
> >> shows:
> >> test    proc    before  after
> >> access1 1       1310582 2908735  (+121%)  # distinct files
> >> access1 24      4716491 63822173 (+1353%) # distinct files
> >> access2 24      2378041 5370335  (+125%)  # same file
> >
> > Out of curiosity, do you have any measurements of the impact this
> > patch has on the AT_EACCESS case when the creds do need to be
> > modified?
>
> I could not be arsed to bench that. I'm not saying there is literally 0
> impact, but it should not be high and the massive win in the case I
> patched imho justifies it.

That's one way to respond to an honest question asking if you've done
any tests on the other side of the change.  I agree the impact should
be less than the advantage you've shown, but sometimes it's nice to
see these things.

> Last week I got a private reply from Linus suggesting the new checks
> only happen once at commit_cred() time, which would mean there would be
> at most one extra branch for the case you are concerned with. However,
> this quickly turn out to be rather hairy as there are games being
> played for example in copy_creds() which assigns them *without* calling
> commit_creds(). I was not comfortable pre-computing without sorting out
> the mess first and he conceded the new branchfest is not necessarily a
> big deal.
>
> That said, if you want some performance recovered for this case, here
> is an easy one:
>
> static const struct cred *access_override_creds(void)
> [..]
>         old_cred = override_creds(override_cred);
>
>         /* override_cred() gets its own ref */
>         put_cred(override_cred);
>
> As in the new creds get refed only to get unrefed immediately after.
> Whacking the 2 atomics should make up for it no problem on x86-64.
>
> Also see below.
>
> >> The above benchmarks are not integrated into will-it-scale, but can be
> >> found in a pull request:
> >> https://github.com/antonblanchard/will-it-scale/pull/36/files
> >>
> >> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> >>
> >> v2:
> >> - fix current->cred usage warn reported by the kernel test robot
> >> Link: https://lore.kernel.org/all/202301150709.9EC6UKBT-lkp@intel.com/
> >> ---
> >>  fs/open.c | 32 +++++++++++++++++++++++++++++++-
> >>  1 file changed, 31 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/open.c b/fs/open.c
> >> index 82c1a28b3308..3c068a38044c 100644
> >> --- a/fs/open.c
> >> +++ b/fs/open.c
> >> @@ -367,7 +367,37 @@ COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode,
> >> compat_arg_u64_dual(offset
> >>   * access() needs to use the real uid/gid, not the effective uid/gid.
> >>   * We do this by temporarily clearing all FS-related capabilities and
> >>   * switching the fsuid/fsgid around to the real ones.
> >> + *
> >> + * Creating new credentials is expensive, so we try to skip doing it,
> >> + * which we can if the result would match what we already got.
> >>   */
> >> +static bool access_need_override_creds(int flags)
> >> +{
> >> +       const struct cred *cred;
> >> +
> >> +       if (flags & AT_EACCESS)
> >> +               return false;
> >> +
> >> +       cred = current_cred();
> >> +       if (!uid_eq(cred->fsuid, cred->uid) ||
> >> +           !gid_eq(cred->fsgid, cred->gid))
> >> +               return true;
> >> +
> >> +       if (!issecure(SECURE_NO_SETUID_FIXUP)) {
> >> +               kuid_t root_uid = make_kuid(cred->user_ns, 0);
> >> +               if (!uid_eq(cred->uid, root_uid)) {
> >> +                       if (!cap_isclear(cred->cap_effective))
> >> +                               return true;
> >> +               } else {
> >> +                       if (!cap_isidentical(cred->cap_effective,
> >> +                           cred->cap_permitted))
> >> +                               return true;
> >> +               }
> >> +       }
> >> +
> >> +       return false;
> >> +}
> >
> > I worry a little that with nothing connecting
> > access_need_override_creds() to access_override_creds() there is a bug
> > waiting to happen if/when only one of the functions is updated.
>
> These funcs are literally next to each other, I don't think that is easy
> to miss. I concede a comment in access_override_creds to take a look at
> access_need_override_creds would not hurt, but I don't know if a resend
> to add it is justified.

Perhaps it's because I have to deal with a fair amount of code getting
changed in one place and not another, but I would think that a comment
would be the least one could do here and would justify a respin.

> > Given the limited credential changes in access_override_creds(), I
> > wonder if a better solution would be to see if we could create a
> > light(er)weight prepare_creds()/override_creds() that would avoid some
> > of the prepare_creds() hotspots (I'm assuming that is where most of
> > the time is being spent).  It's possible this could help improve the
> > performance of other, similar operations that need to modify task
> > creds for a brief, and synchronous, period of time.

...

> For a Real Solution(tm) for a general case I think has to start with an
> observartion creds either persist for a long time *OR* keep getting
> recreated. This would suggest holding on to them and looking them up
> instead just allocating, but all this opens another can of worms and
> I don't believe is worth the effort at this stage. But maybe someone
> has a better idea.
>
> That said, for the case of access(), I had the following in mind but
> once more considered it not justified at this stage.
>
> pseudocode-wise:
> struct cred *prepare_shallow_creds(void)
>         new = kmem_cache_alloc(cred_jar, GFP_KERNEL);
>         old = task->cred;
>         memcpy(new, old, sizeof(struct cred));
>
> here new creds have all the same pointers as old, but the target objs
> are only kept alive by the old creds still refing them. So by API
> contract you are required to keep them around.
>
> after you temporarily assign them you call revert_shallow_creds():
>         if (tempcred->usage == 1)
>                 /* nobody refed them, do the non_rcu check */
>                 ...
>         else
>                 /* somebody grabbed them, legitimize creds by
>                  * grabbing the missing refs
>                  */
>                  get_uid(new->user);
>                  get_user_ns(new->user_ns);
>                  get_group_info(new->group_info);
>                  /* and so on */
>
> So this would shave work from the case you are concerned with probably
> for all calls.
>
> I do think this is an ok idea overall, but I felt like overengineering for the
> problem at hand *at the time*.

In my opinion a generalized shallow copy approach has more value than
a one-off solution that has the potential to fall out of sync and
cause a problem in the future (I recognize that you disagree on the
likelihood of this happening).

> For some context, I'm looking at performance of certain VFS stuff and
> there is some serious fish to fry in the fstat department.

I assumed it was part of some larger perf work, but I'm not sure the
context is that important for this particular discussion.

> The patch I
> posted is definitely worthwhile perf-wise and easy enough to reason
> about that I did no expect much opposition to it. If anything I expected
> opposition to the idea outlined above.

Ultimately it's a call for the VFS folks as they are responsible for
the access() code.

--
paul-moore.com
