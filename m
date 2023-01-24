Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341DC67A503
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 22:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbjAXVde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 16:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjAXVdd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:33:33 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF5E47422
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 13:33:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 78so12177092pgb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 13:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E7BYv9YvD7kf79/IwjnV76gbkJW2mIWLBYMWUaTCArA=;
        b=PrNWgIsh73lH3egdEzxLAxzr1+2yJdCvMhCOi5Ex7p2WqIQqOGPbMgPKyiPbQXz8mh
         3nz6TK++fbbefkEkD4I30JBKtNJiwVR/1uh3tKr7+/Dq55fbs49io42cKNpstkqUUVCp
         qbpPPibXUEYDFVQrekiBQNAl0fIDwxmc3UDfUmN+yR/lei8qzkTmI35cH+2HD1bBd5IM
         wGEy0mzCdmPBwa4WrRwCEtdW5LuGDo+Rx5Jvpd2GqpjmLrXWDqc7RJp7CWLEN1XlWoub
         WCgaySVkDkfSRj1JN3evq7U8eUVpxzudQn2wWxkXwgREoUy8NoHEfoaWhmImh7WoUO7H
         YNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7BYv9YvD7kf79/IwjnV76gbkJW2mIWLBYMWUaTCArA=;
        b=1kvXiLU7xQINiuts77I3o/soBIq1Cqmq3Z7laSkmRxyHQW2YWxeOyK7uPykte8H1L5
         +PbIE7GlvIhTM9k1aT5OIl7c/bU073Ij7RYiZBhGoq6mnta7E6F519NKuu8P3gnLKlmU
         ugfIT9KbvrIq4aUi5e3eUJcFm6oBw6zfybnix81mBEKvkK4hgV8OF1INHAIyGpRAtLv2
         27LVAxXEbq5kaKZzvjUuZT9Qs1ibz39smqmLNrBPmvWEV+PRvcwxGqGYF/9AFv2+MX6C
         uojnHz/sNloPtbtD12MMW2x9od94bJND+gNl052UHf0kECfxo7IpIDE/5GGCfzGp4qnO
         6Sqg==
X-Gm-Message-State: AFqh2kqroA+6XuaiOkyE9HFSGxFazEsMFrGh4FPcI+m3k3NW3gGmtH5A
        1BU5gF06exKVwGdvWdZ1i4CEUQuB0ejIAL/24wqI
X-Google-Smtp-Source: AMrXdXu0Wrp/znCawGnT5ZD4xqZ7UWAUgqmiCrNUDYnxLwgerZRPsHo445vKO6Z2Ku61/EGEHjbpju4TLlQvS2P3dOc=
X-Received: by 2002:a62:1495:0:b0:587:5488:c8b6 with SMTP id
 143-20020a621495000000b005875488c8b6mr3261347pfu.3.1674596011203; Tue, 24 Jan
 2023 13:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
 <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
 <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com> <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jan 2023 16:33:20 -0500
Message-ID: <CAHC9VhTg8mMHzdSPbpxvOQCWxuNuXzR7c6FJOg5+XGb-PYemRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, linux-fsdevel@vger.kernel.org,
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

On Tue, Jan 24, 2023 at 12:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jan 24, 2023 at 9:00 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > My main concern is the duplication between the cred check and the cred
> > override functions leading to a bug at some unknown point in the
> > future.
>
> Yeah, it might be good to try to have some common logic for this,
> although it's kind of messy.
>
> The access_override_creds() logic is fairly different from the "do I
> need to create new creds" decision, since instead of *testing* whether
> the fs[ug]id and [ug]id matches, it just sets the fs[ug]id to the
> expected values.
>
> So that part of the test doesn't really exist.
>
> And the same is true of the !SECURE_NO_SETUID_FIXUP logic case - the
> current access() override doesn't _test_ those variables for equality,
> it just sets them.
>
> So Mateusz' patch doesn't really duplicate any actual logic, it just
> has similarities in that it checks "would that new cred that
> access_override_creds() would create be the same as the old one".

Perhaps I didn't do a very good job explaining my concern, or it got a
little twisted as the thread went on (likely due to my use of
"duplication"), but my concern wasn't so much that
access_override_creds() or the proposed access_need_override_creds()
duplicates code elsewhere, it was that the proposed
access_need_override_creds() function is a separate check from the
code which is actually responsible for doing the credential fixup for
AT_EACCESS.  I'm worried about a subtle change in one function not
being reflected in the other and causing an access control bug.

> The new access_need_override_creds() function is right next to the
> pre-existing access_override_creds() one, so at least they are close
> to each other. That may be the best that can be done.

Possibly, and the comment should help.

Although I'm looking at this again and realized that only
do_faccessat() calls access_override_creds(), so why not just fold the
new access_need_override_creds() logic into access_override_creds()?
Just have one function that takes the flag value, and returns an
old_cred/NULL pointer (or pass old_cred to the function by reference
and return an error code); that should still provide the performance
win Mateusz is looking for while providing additional safety against
out-of-sync changes.  I would guess the code would be smaller too.

> Maybe some of the "is it the root uid" logic could be shared, though.
> Both cases do have this part in common:
>
>         if (!issecure(SECURE_NO_SETUID_FIXUP)) {
>                 /* Clear the capabilities if we switch to a non-root user */
>                 kuid_t root_uid = make_kuid(override_cred->user_ns, 0);
>                 if (!uid_eq(override_cred->uid, root_uid))
>
> and that is arguably the nastiest part of it all.
>
> I don't think it's all that likely to change in the future, though
> (except for possible changes due to user_ns re-orgs, but then changing
> both would be very natural).

You're probably right.  As I said earlier, I'm just really sensitive
to code that is vulnerable to going out of sync like this and I try to
avoid it whenever possible.

-- 
paul-moore.com
