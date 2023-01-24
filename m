Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94645679500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 11:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjAXKQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 05:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAXKQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:16:41 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FD840BC4;
        Tue, 24 Jan 2023 02:16:31 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-15b9c93848dso17179840fac.1;
        Tue, 24 Jan 2023 02:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/5WiIONj0PqeupOjNCUoWXxpeYBFDGqt1Kmioz3LF90=;
        b=e+RWkTufJc7KegDl3Bld1F56EYRwgNr8+jzVZiAArbmeUUDHLUHxEsTlQxpS3kFp7P
         FyfiwOvfcS2LfKZNDplEX7lV4sA3eigHVkCZDw8tzI0rFt1FjgaPIJ+4vOGkl5KUVjmm
         LL5JlU47Kkrzy67eeMm/EtQ1KPTJwf7tSlXl5LqyXrT70cec4k52pzxsoaHzPyjl5Z1p
         SLQhvULYBD95fegidttfKnzP4t6bdThAS9AUw40JQt/BgtQLweMHhNqZdFG//wPLhQln
         m3zUTpz0O4IKM7htj2m8UBT9BEfCPyHhcFqGVfrxtHzAy6gU8RFwkSsyu8OKkPZUaDJk
         2w9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5WiIONj0PqeupOjNCUoWXxpeYBFDGqt1Kmioz3LF90=;
        b=LoLBijxyg7UubWzChlV9+Lxtqp26aqO5FOt+MS/5a58c7xjQM26Pwa0aNw/PZZ3QwE
         cqfeUW+hXSbZy4B7k+hP+Ywg9n/yk3LzX2Bv/9kZMTUvs01xNMM7BFqVRngNaxFt3rx7
         FDv5Cy4yz8n8fHdrSC7yvUjWK0hPgP59tQFx57AeCvpvSCJwbfDPvE+/ZYtg+KCkoNV1
         ZgxFAKfLt/oikl5fuRqDJDAPhPWRhQYo4ozGk+NKwAwA1QinLwB/mJI9+T5/qbVUkmex
         +sQP1dnBE4XDzcf/4UJb6slGlZ9G+76LHw43g2BiWhZyeqXXTNBXLfysjw/dVUAsWjK7
         S+vA==
X-Gm-Message-State: AO0yUKUvq7cOh+47Y9nzWakL4lVn6qB0yh+YazxUuo4HUX/SGa20Azx2
        LZDlGCXSqf8aZIBmhl88zmlqhGRSaukcRwm8/gv+8Di8
X-Google-Smtp-Source: AK7set8gaJfUZINs20aHCgEW8AaCJ13bIBWTnki0UIKMeYGbI1vy+9GxoXIV78MMF1NbYAzDZILjc4S+bxoe+9BBbGs=
X-Received: by 2002:a05:6870:10d5:b0:163:1dac:5acb with SMTP id
 21-20020a05687010d500b001631dac5acbmr48049oar.159.1674555390726; Tue, 24 Jan
 2023 02:16:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:ad6:0:b0:49c:e11d:f815 with HTTP; Tue, 24 Jan 2023
 02:16:29 -0800 (PST)
In-Reply-To: <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com> <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 24 Jan 2023 11:16:29 +0100
Message-ID: <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Paul Moore <paul@paul-moore.com>
Cc:     viro@zeniv.linux.org.uk, serge@hallyn.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/23/23, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jan 20, 2023 at 7:50 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>> On 1/20/23, Paul Moore <paul@paul-moore.com> wrote:
>> > On Mon, Jan 16, 2023 at 4:21 PM Mateusz Guzik <mjguzik@gmail.com>
>> > wrote:
>> >>
>> >> access(2) remains commonly used, for example on exec:
>> >> access("/etc/ld.so.preload", R_OK)
>> >>
>> >> or when running gcc: strace -c gcc empty.c
>> >> % time     seconds  usecs/call     calls    errors syscall
>> >> ------ ----------- ----------- --------- --------- ----------------
>> >>   0.00    0.000000           0        42        26 access
>> >>
>> >> It falls down to do_faccessat without the AT_EACCESS flag, which in
>> >> turn
>> >> results in allocation of new creds in order to modify fsuid/fsgid and
>> >> caps. This is a very expensive process single-threaded and most
>> >> notably
>> >> multi-threaded, with numerous structures getting refed and unrefed on
>> >> imminent new cred destruction.
>> >>
>> >> Turns out for typical consumers the resulting creds would be identical
>> >> and this can be checked upfront, avoiding the hard work.
>> >>
>> >> An access benchmark plugged into will-it-scale running on Cascade Lake
>> >> shows:
>> >> test    proc    before  after
>> >> access1 1       1310582 2908735  (+121%)  # distinct files
>> >> access1 24      4716491 63822173 (+1353%) # distinct files
>> >> access2 24      2378041 5370335  (+125%)  # same file
>> >
>> > Out of curiosity, do you have any measurements of the impact this
>> > patch has on the AT_EACCESS case when the creds do need to be
>> > modified?
>>
>> I could not be arsed to bench that. I'm not saying there is literally 0
>> impact, but it should not be high and the massive win in the case I
>> patched imho justifies it.
>
> That's one way to respond to an honest question asking if you've done
> any tests on the other side of the change.  I agree the impact should
> be less than the advantage you've shown, but sometimes it's nice to
> see these things.
>

So reading this now I do think it was worded in quite a poor manner, so
apologies for that.

Wording aside, I don't know whether this is just a passing remark or
are you genuinely concerned about the other case.

If you are, I noted there is an immediately achievable speed up by
eliminating the get/put ref cycle on creds coming from override_creds +
put_cred to backpedal from it. This should be enough to cover it, but
there are cosmetic problems around it I don't want to flame over.

Say override_creds_noref gets added doing the usual work, except for
get_new_cred.

Then override_creds would be:
        validate_creds(new);
        get_new_cred((struct cred *)new);
        override_creds_noref(new);

But override_creds_noref would retain validate_creds new/old and the
above would repeat it which would preferably be avoided. Not a problem
if it is deemed ok to get_new_cred without validate_creds.

>> These funcs are literally next to each other, I don't think that is easy
>> to miss. I concede a comment in access_override_creds to take a look at
>> access_need_override_creds would not hurt, but I don't know if a resend
>> to add it is justified.
>
> Perhaps it's because I have to deal with a fair amount of code getting
> changed in one place and not another, but I would think that a comment
> would be the least one could do here and would justify a respin.
>

I'm not going to *insist* on not adding that comment.

Would this work for you?

diff --git a/fs/open.c b/fs/open.c
index 3c068a38044c..756177b94b04 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -407,6 +407,11 @@ static const struct cred *access_override_creds(void)
        if (!override_cred)
                return NULL;

+       /*
+        * XXX access_need_override_creds performs checks in hopes of
+        * skipping this work. Make sure it stays in sync if making any
+        * changes here.
+        */
        override_cred->fsuid = override_cred->uid;
        override_cred->fsgid = override_cred->gid;

if not, can you phrase it however you see fit for me to copy-paste?

> In my opinion a generalized shallow copy approach has more value than
> a one-off solution that has the potential to fall out of sync and
> cause a problem in the future (I recognize that you disagree on the
> likelihood of this happening).
>

To reiterate my stance, the posted patch is trivial to reason about
and it provides a marked improvement for the most commonly seen case.
It comes with some extra branches for the less common case, which I
don't consider to be a big deal.

From the quick toor I took around kernel/cred.c I think the cred code
is messy and it would be best to sort it out before doing anything
fancy. I have no interest in doing the clean up.

The shallow copy idea I outlined above looks very simple, but I can't
help the feeling there are surprises there, so I'm reluctant to roll
with it as is.

More importantly I can't show any workload which runs into the other
case, thus if someone asks me to justify the complexity I will have
nothing, which is mostly why I did not go for it.

That said, if powers to be declare this is the way forward, I can
spend some time getting it done.

> Ultimately it's a call for the VFS folks as they are responsible for
> the access() code.
>

Well let's wait and see. :)

-- 
Mateusz Guzik <mjguzik gmail.com>
