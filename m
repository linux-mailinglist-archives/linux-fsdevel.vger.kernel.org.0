Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3467A194
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 19:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjAXSnP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 13:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjAXSnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:43:04 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19209166DE;
        Tue, 24 Jan 2023 10:42:57 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-15b9c93848dso18749142fac.1;
        Tue, 24 Jan 2023 10:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wiC7R/H94hYc1SsjxtFjmBRg+lLwk6SCWMFgpc1MdSs=;
        b=TWgfRWQ1fiNK9XA0MeyWCulPPMMPqNScBqLHRvlK6asoKbQj9I0w6ySJijKI+mhMT8
         pRnZDojAvcUNveVWtL1UWkAJ6zTSCUAbo5UNdTdmSaW6AV/Wr33UDUBcr6cO+2pHFkwe
         G/piuIrO5Vb167eQnFEvCsEi1aq8oJzQSZjLzScoLNLbF5GdveawKeGu0G2+8/tGRMbl
         E9ajFnwZuXJNlk/ROCjHZzvanQHNAUxvWie/YsD3BvzPxx5DpEoGTePvjKBYSvAbcQEe
         MLrcimPt1cSVDJ+Q9Detk45kXFYiVobuCsfoRzp3IWBharfpwmF1HBtC87H3MSYidHIG
         gdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiC7R/H94hYc1SsjxtFjmBRg+lLwk6SCWMFgpc1MdSs=;
        b=0UBYV48mrppEyAaHGAAaa5036iKRK4Kl0D8mbLvPcQcGO7U7+Kf4AmBVG0E5dYSM80
         GkB9vQDnvgiUW93Yhle3wHkSoUOybHfH1LvDiD6zGzEfgsoQoLBwmdE6fBk03fg7im3n
         es8AhKSLdz69Ruuvuz9GIcUs6TEm+OEfU/WjB6H4G2cFvKeB721h6ezNKkVWCebvk9/H
         FOvlybTSx4nv2QUMTCQcxPxiEjLpUhCVwmFy6ej2t7bxuPcHaACsiE8n2o0SZyZAHZQT
         Go6FDeMNa68soYWyw8tK34XL69GS+qxODHOqM9CUTK44m3Ce8QQjYBTKrS3UlAvKsosD
         4kDg==
X-Gm-Message-State: AO0yUKVgFtHjyK+Cm2QAC9bsAaQQQNO8ZrQW2iidzotLT4UIQ/AbgWpj
        f7w3X/yF02TX+eMuqPrXq45Rc1yAClEH3zMaKEs=
X-Google-Smtp-Source: AK7set/yUllb1k65k/qoEf6g8aCEBffXa0VIT5A8LJQ/UtfJd94cYwGOrF92P7dAa0f9KBNc/egCyQP7T7Rgfgrct00=
X-Received: by 2002:a05:6870:1115:b0:163:1d2a:aa5d with SMTP id
 21-20020a056870111500b001631d2aaa5dmr124635oaf.81.1674585776376; Tue, 24 Jan
 2023 10:42:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:ad6:0:b0:49c:e11d:f815 with HTTP; Tue, 24 Jan 2023
 10:42:55 -0800 (PST)
In-Reply-To: <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com>
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
 <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
 <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com> <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 24 Jan 2023 19:42:55 +0100
Message-ID: <CAGudoHG22iS3Bt1rh_kEJDEstj3r1Mj4Z305vqRbP8vBjQZ3dg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Moore <paul@paul-moore.com>, viro@zeniv.linux.org.uk,
        serge@hallyn.com, linux-fsdevel@vger.kernel.org,
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

On 1/24/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Jan 24, 2023 at 9:00 AM Paul Moore <paul@paul-moore.com> wrote:
>>
>> My main concern is the duplication between the cred check and the cred
>> override functions leading to a bug at some unknown point in the
>> future.
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
>
> So sharing code is hard, because the code is fundamentally not the same.
>
> The new access_need_override_creds() function is right next to the
> pre-existing access_override_creds() one, so at least they are close
> to each other. That may be the best that can be done.
>
> Maybe some of the "is it the root uid" logic could be shared, though.
> Both cases do have this part in common:
>
>         if (!issecure(SECURE_NO_SETUID_FIXUP)) {
>                 /* Clear the capabilities if we switch to a non-root user
> */
>                 kuid_t root_uid = make_kuid(override_cred->user_ns, 0);
>                 if (!uid_eq(override_cred->uid, root_uid))
>
> and that is arguably the nastiest part of it all.
>
> I don't think it's all that likely to change in the future, though
> (except for possible changes due to user_ns re-orgs, but then changing
> both would be very natural).
>

You could dedup make_kuid + uid_eq check, but does it really buy
anything?

ns changes which break compilation will find both spots. Similarly
any grep used to find one should also automagically find the other
one.

I think this patch generated way more discussion than it warrants,
especially since I deliberately went for the trivial approach in
hopes of avoiding this kind of stuff.

So how about I simply respin with the comment I mailed earlier,
repasted here for reference (with a slight tweak):

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
+        * changes in this routine.
+        */
        override_cred->fsuid = override_cred->uid;
        override_cred->fsgid = override_cred->gid;

sounds like a plan?

-- 
Mateusz Guzik <mjguzik gmail.com>
