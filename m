Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C93F7B0B59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 19:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjI0R4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 13:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0R4m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:56:42 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F0DEB;
        Wed, 27 Sep 2023 10:56:40 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b9231e91dso5230191eaf.2;
        Wed, 27 Sep 2023 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837399; x=1696442199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N65R+6NVeQxsjzZ/9Yt0tbADHWNCLlV6RIkP1ydvJS4=;
        b=a55qfaOiK9lOQfE4tNwQ32U00gL9ArqERtvsPVF7j2GKz6CXQcu95T4R47j6H0P3ql
         t9dfEOkNNR0Mlb7eTluXTGOm76HqWPl0REgw+gEzDigGheVR6JddspAaddIPRrHlT5KB
         XcYK0EKCJgCyQIRlE0d/CqMKlO+CUMZ1esQjnoreaa5ravoWctAioXRBnaMDNNBDRVWM
         gYntSqUzGIy3Pg/xi4MyrnNDqQzPvLeen8YhWf+JCipo31jKzv1XVJ55qRrP6xeDXKMN
         ae0X05ELXJ7pG70YONjKZTi0RTCgeb8CC6PhP1NTL2Yu3+liPinqfWmV2tw39yRKjmnB
         peZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837399; x=1696442199;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N65R+6NVeQxsjzZ/9Yt0tbADHWNCLlV6RIkP1ydvJS4=;
        b=rk21CFhxhY5cR1Vh9gHmOiPHXoEWOM0orwQfAcRttwXavQ+jJb9o+8rdXNfCCNjUQi
         wvPSqfmV5kClguTcvhLoMEoag1PDPV6uOIJOW1KXr4qwOKEyvcKJwR3vIrJlwBI6gud5
         nNSqITGhdw5X89PjX8GxYEs54kk+0R0AZELMD1q3BlDquLorx7IhsubR5t7lEwUYRUgW
         2coa1bzU0i0lVG3+3TwQE/QpXJzQkRf60y4YuEw6p0zJqLOsMlX3uJRDMZk3VNCoiWlf
         jiEqB7hFcG5KumLAeB3La+s1xkz0oFtwWKm6NO558iFtECLnYr9hNRoJcuwVjIORn3SA
         Xkvw==
X-Gm-Message-State: AOJu0Yx2QJ25+fuuEWARglK0sPr+fPxW4KX6R25qhdMX1cflp2uhEWf2
        LAYJUOT/63XJc+s3U5MuWMBfiZ72bJD/fI5z+7I=
X-Google-Smtp-Source: AGHT+IE1M1+I4nmHeUbQZJP33DB65w1VkqbCRMkekRdLlcy/PHPrshgC8bLIZPciI2mA39Rv4lP6G/81LRLpBb9xqtA=
X-Received: by 2002:a4a:6243:0:b0:57b:82d2:8253 with SMTP id
 y3-20020a4a6243000000b0057b82d28253mr2859256oog.3.1695837399614; Wed, 27 Sep
 2023 10:56:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5785:0:b0:4f0:1250:dd51 with HTTP; Wed, 27 Sep 2023
 10:56:39 -0700 (PDT)
In-Reply-To: <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner> <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 27 Sep 2023 19:56:39 +0200
Message-ID: <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On 9/27/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 27 Sept 2023 at 07:10, Christian Brauner <brauner@kernel.org>
> wrote:
>>
>> No need to resend I can massage this well enough in-tree.
>
> Hmm. Please do, but here's some more food for thought for at least the
> commit message.
>
> Because there's more than the "__fput_sync()" issue at hand, we have
> another delayed thing that this patch ends up short-circuiting, which
> wasn't obvious from the original description.
>
> I'm talking about the fact that our existing "file_free()" ends up
> doing the actual release with
>
>         call_rcu(&f->f_rcuhead, file_free_rcu);
>
> and the patch under discussion avoids that part too.
>

Comments in the patch explicitly mention dodgin RCU for the file object.

> And I actually like that it avoids it, I just think it should be
> mentioned explicitly, because it wasn't obvious to me until I actually
> looked at the old __fput() path. Particularly since it means that the
> f_creds are free'd synchronously now.
>

Well put_cred is called synchronously, but should this happen to be
the last ref on them, they will get call_rcu(&cred->rcu,
put_cred_rcu)'ed.

> I do think that's fine, although I forget what path it was that
> required that rcu-delayed cred freeing. Worth mentioning, and maybe
> worth thinking about.
>

See above. The only spot which which plays tricks with it is
faccessat, other than that all creds are explicitly freed with rcu.

> However, when I *did* look at it, it strikes me that we could do this
> differently.
>
> Something like this (ENTIRELY UNTESTED) patch, which just moves this
> logic into fput() itself.
>

I did not want to do it because failed open is a special case, quite
specific to one syscall (and maybe few others later).

As is you are adding a branch to all final fputs and are preventing
whacking that 1 -> 0 unref down the road, unless it gets moved out
again like in my patch.

-- 
Mateusz Guzik <mjguzik gmail.com>
