Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21BB4E5171
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 12:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiCWLmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 07:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbiCWLmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:42:01 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EAD7938B
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 04:40:31 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o64so1327335oib.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 04:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1ab5bi75W4ompR5LIqMFnRiwZn4qkO0v8ob/jLXPKI=;
        b=m855rGmj/6IeL21EAPjnmZpQakX0UK7gYmty02mnoNHRm65WjWqSGc9+miz10WKrgh
         mTlluotyB2EM/X/ij7zG3T60c6GivGxMHsSZsjTW3NxCeFdpa4zDdygg6L4zRhZSAGja
         rWDg8edkSWECEIKxiuuiGOrVLeqm3jI6WWF3xTzcIybArtikHpHV/Wo9fmKV8ua5JGjH
         i8cGtV3/K4jqL3u7jn4MWKSUCsGcer6loNIhW1LuyPjAiCnr96QjdwSsx8bnCjE6IBAT
         4o9WpzSSWfAK58e/+AFoqSIWQoP5HnCQlc23cW3jGZ6uciHRl8D6nVQsKNHxngwyd9I+
         A6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1ab5bi75W4ompR5LIqMFnRiwZn4qkO0v8ob/jLXPKI=;
        b=gZ6bKd5s8s4k6xgp2n//2IsFBczauvxBuqkboP0NNibv+6iN0wE5h+aiC7bB/xcD8s
         fXqED5Mjh++54NS+8qX0J8McO//7IlhCohdKI5xPXgus4GDxnIKM3Kwt2cH8puZO6nkJ
         OlIGgQcwZ48fskphjerCFZz5h4FEx9fONSJz+8Cr+ZXd8dDAm60xJDuxiySLVJqU82+h
         83/WqxduGnOA8uc1WqvYYnjtCJdNP6H9DmvwnI8Rd2b9PI+F950qqbeN1Xx8GEkHLZv2
         zNGms3vJxYXYfyC0AwdgiJyVz7J9M2yqTuouE974gECDXSQUr1MYNhgWIgSuHlO+Ttjy
         2XiQ==
X-Gm-Message-State: AOAM532jUC8niWF61bxtKtFylblHcfrnLdfkG1CShNhG7PhyHm13bD4s
        3RIhH7KUu2lceEXOIY/HUPSs7UdydhQ0CTfGpU4=
X-Google-Smtp-Source: ABdhPJyE+lCQz6ijmJQZR301OPZ2pEzUyrDyIgkEac0graga/VqK5/8xJ/i7HVy7SB8iXAQtYy7C5DYAiQrfh7SHnyY=
X-Received: by 2002:aca:4005:0:b0:2ef:84d3:f282 with SMTP id
 n5-20020aca4005000000b002ef84d3f282mr3194886oia.98.1648035630348; Wed, 23 Mar
 2022 04:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220319001635.4097742-1-khazhy@google.com> <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
 <20220321112310.vpr7oxro2xkz5llh@quack3.lan> <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
 <20220321145111.qz3bngofoi5r5cmh@quack3.lan> <CAOQ4uxgOpfezQ4ydjP4SPA8-7x9xSXjTmTyZOYQE3d24c2Zf7Q@mail.gmail.com>
 <20220323104129.k4djfxtjwdgoz3ci@quack3.lan>
In-Reply-To: <20220323104129.k4djfxtjwdgoz3ci@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Mar 2022 13:40:18 +0200
Message-ID: <CAOQ4uxgH3aCKnXfUFuyC7JXGtuprzWr6U9Y2T1rTQT3COoZtzw@mail.gmail.com>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
To:     Jan Kara <jack@suse.cz>
Cc:     "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 12:41 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 23-03-22 00:41:28, Amir Goldstein wrote:
> > > > > So the cleanest solution I currently see is
> > > > > to come up with helpers like "fsnotify_lock_group() &
> > > > > fsnotify_unlock_group()" which will lock/unlock mark_mutex and also do
> > > > > memalloc_nofs_save / restore magic.
> > > > >
> > > >
> > > > Sounds good. Won't this cause a regression - more failures to setup new mark
> > > > under memory pressure?
> > >
> > > Well, yes, the chances of hitting ENOMEM under heavy memory pressure are
> > > higher. But I don't think that much memory is consumed by connectors or
> > > marks that the reduced chances for direct reclaim would really
> > > substantially matter for the system as a whole.
> > >
> > > > Should we maintain a flag in the group FSNOTIFY_GROUP_SHRINKABLE?
> > > > and set NOFS state only in that case, so at least we don't cause regression
> > > > for existing applications?
> > >
> > > So that's a possibility I've left in my sleeve ;). We could do it but then
> > > we'd also have to tell lockdep that there are two kinds of mark_mutex locks
> > > so that it does not complain about possible reclaim deadlocks. Doable but
> > > at this point I didn't consider it worth it unless someone comes with a bug
> > > report from a real user scenario.
> >
> > Are you sure about that?
>
> Feel free to try it, I can be wrong...
>
> > Note that fsnotify_destroy_mark() and friends already use lockdep class
> > SINGLE_DEPTH_NESTING, so I think the lockdep annotation already
> > assumes that deadlock from direct reclaim cannot happen and it is that
> > assumption that was nearly broken by evictable inode marks.
> >
> > IIUC that means that we only need to wrap the fanotify allocations
> > with GFP_NOFS (technically only after the first evictable mark)?
>
> Well, the dependencies lockdep will infer are: Once fsnotify_destroy_mark()
> is called from inode reclaim, it will record mark_mutex as
> 'fs-reclaim-unsafe' (essentially fs_reclaim->mark_mutex dependency). Once
> filesystem direct reclaim happens from an allocation under mark_mutex,
> lockdep will record mark_mutex as 'need-to-be-fs-reclaim-safe'
> (mark_mutex->fs_reclaim) dependency. Hence a loop. Now I agree that
> SINGLE_DEPTH_NESTING (which is BTW used in several other places for unclear
> reasons - we should clean that up) might defeat this lockdep detection but
> in that case it would also defeat detection of real potential deadlocks
> (because the deadlock scenario you've found is real). Proper lockdep

Definitely. My test now reproduces the deadlock very reliably within seconds
lockdep is unaware of the deadlock because of the SINGLE_DEPTH_NESTING
subclass missguided annotation.

> annotation needs to distinguish mark_locks which can be acquired from under
> fs reclaim and mark_locks which cannot be.
>

I see. So technically we can annotate the fanotify group mark_mutex with
a different key and then we have 4 subclasses of lock:
- fanotify mark_mutex are NOT reclaim safe
- non-fanotify mark_mutex are reclaim safe
- ANY mark_mutex(SINGLE_DEPTH_NESTING) are fs-reclaim unsafe

The reason I am a bit uneasy with regressing inotify is that there are users
of large recursive inotify watch crawlers out there (e.g. watchman) and when
crawling a large tree to add marks, there may be a need to reclaim
some memory by evicting inode cache (of non-marked subtrees).

Thanks,
Amir.
