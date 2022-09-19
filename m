Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3FE5BD458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiISSFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiISSFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:05:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062D8E0D3;
        Mon, 19 Sep 2022 11:05:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y5so401909wrh.3;
        Mon, 19 Sep 2022 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vb/BXICUNW5+h3UQtwzUqhGAHWrBZN2A+UXNfCT8Pqc=;
        b=Ns9exaZ9YtultAtWZhCFpGg1KR2dHcqO6XVgDCwr+eBGnRvIT8NEw/A/jkKbMICRJN
         vyk9IGJ2CvNUhq1AooQQQabinD7v2+YVXYuUueA0LikjHOLgB0FCY/YztXTwzkwb6sio
         ddGcL7vDyMmCiRLvD+CX99sYNptj+i7rzzHoJS2gt+R3uMGbTs26GZNlSP95RJoH1l8B
         Ga4gG1adKUtjr8QwtnFsh1H8wC2KLkLD4xYZrIzizvvo0cILv6a3Gojc4WYS2ntF2p3t
         lqMIkKZ6g4mr1NDoZ+jTX0r/wt9v9WbnUYFSJyGR++cOu5S4otfkRSklsQv1oljWKyud
         OpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vb/BXICUNW5+h3UQtwzUqhGAHWrBZN2A+UXNfCT8Pqc=;
        b=TGr6fCjgrSKenxMW8Onm9spn+UOcEKs+1h2EK59hF7Lbqi/9l6LJFABn60NidLwoco
         kDoWt0iyxJ06EgaphxG92B3HqjAYmlKGo7pQ77LU9qf1oIQJC1fbj1Z+YnPcctjUtLAU
         n5kOqrOlMoEV8qyFcgaVj3/jFBG/rLUXh1+aHU5xjIns33Z1GSstUPvbqe7KI7ir8R8r
         C8CcF4MqhGoGYn0K3G+y/RoC8i8FcajtQq0ZgWIHDaU5EBjyw4H/sxZgPJ7bg0/4V++h
         NaBh6ug3HhsRYAiLMTK4srLJFanwLkme9zyq+cwenHEKP4hgsx4xU9+pSeAMKn6zXWe3
         1MfA==
X-Gm-Message-State: ACrzQf3jRZAPeUtqgaBn0W2ivXinySmdImr8tYsHRp4InnBtFf/Y4dCk
        j1e9ukkvjXU+Qb0yWUvsIjY=
X-Google-Smtp-Source: AMsMyM5H7HXR/4Iir7gke5r6YX2qJZWSIMlDJoDP74sxpyTqChBYtElhHroI7JGUDABxT9OErvuQow==
X-Received: by 2002:a05:6000:14c:b0:22a:c14a:29f8 with SMTP id r12-20020a056000014c00b0022ac14a29f8mr11434021wrx.588.1663610727419;
        Mon, 19 Sep 2022 11:05:27 -0700 (PDT)
Received: from wedsonaf-dev ([81.2.152.129])
        by smtp.gmail.com with ESMTPSA id s10-20020a5d510a000000b002252884cc91sm14494873wrt.43.2022.09.19.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 11:05:26 -0700 (PDT)
Date:   Mon, 19 Sep 2022 19:05:23 +0100
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Konstantin Shelekhin <k.shelekhin@yadro.com>, ojeda@kernel.org,
        alex.gaynor@gmail.com, ark.email@gmail.com,
        bjorn3_gh@protonmail.com, bobo1239@web.de, bonifaido@gmail.com,
        boqun.feng@gmail.com, davidgow@google.com, dev@niklasmohrin.de,
        dsosnowski@dsosnowski.pl, foxhlchen@gmail.com, gary@garyguo.net,
        geofft@ldpreload.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, john.m.baublitz@gmail.com,
        leseulartichaut@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.falkowski@samsung.com,
        me@kloenk.de, milan@mdaverde.com, mjmouse9999@gmail.com,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, viktor@v-gar.de,
        Andreas Hindborg <andreas.hindborg@wdc.com>
Subject: Re: [PATCH v9 12/27] rust: add `kernel` crate
Message-ID: <YyivY6WIl/ahZQqy@wedsonaf-dev>
References: <20220805154231.31257-13-ojeda@kernel.org>
 <Yu5Bex9zU6KJpcEm@yadro.com>
 <CANiq72=3j2NM2kS8iw14G6MnGirb0=O6XQyCsY9vVgsZ1DfLaQ@mail.gmail.com>
 <Yu6BXwtPZwYPIDT6@casper.infradead.org>
 <Yyh3kFUvt2aMh4nq@wedsonaf-dev>
 <CAHk-=wgaBaVaK2K=N05fwWSSLM6YJx=yLmP4f7j6d6o=nCAtdw@mail.gmail.com>
 <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTDbFZKB4KJ6=74hoLcerTm3JuN3PV8G6ktcz+Xm1qew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:20:52AM -0700, Linus Torvalds wrote:
> On Mon, Sep 19, 2022 at 9:09 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > The whole "really know what context this code is running within" is
> > really important. You may want to write very explicit comments about
> > it.
> 
> Side note: a corollary of this is that people should avoid "dynamic
> context" things like the plague, because it makes for such pain when
> the context isn't statically obvious.

As you know, we're trying to guarantee the absence of undefined
behaviour for code written in Rust. And the context is _really_
important, so important that leaving it up to comments isn't enough.

I don't care as much about allocation flags as I do about sleeping in an
rcu read-side critical region. When CONFIG_PREEMPT=n, if some CPU makes
the mistake of sleeping between rcu_read_lock()/rcu_read_unlock(), RCU
will take that as a quiescent state, which may cause unsuspecting code
waiting for a grace period to wake up too early and potentially free
memory that is still in use, which is obviously undefined behaviour.

We generally have two routes to avoid undefined behaviour: detect at
compile time (and fail compilation) or at runtime (and stop things
before they go too far). The former, while feasible, would require some
static analysi or passing tokens as arguments to guarantee that we're in
sleepable context when sleeping (all ellided at compile time, so
zero-cost in terms of run-time performance), but likely painful to
program use.

Always having preempt_count would allow us to detect such issues in RCU
at runtime (for both C and Rust) and prevent user-after-frees.

Do you have an opinion on the above?

Cheers,
-Wedson
