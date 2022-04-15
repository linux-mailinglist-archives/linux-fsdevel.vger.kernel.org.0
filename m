Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3849502FD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 22:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351250AbiDOUmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 16:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiDOUmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:42:00 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9649FE02D;
        Fri, 15 Apr 2022 13:39:30 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id b17so7146174qvp.6;
        Fri, 15 Apr 2022 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I9VUcQDpCv1rkzrj2b4j+bs9wnou0NsHbd1posW4klQ=;
        b=DyLSFmJHbDwIHskhsP9ITVoyr5YAKPT9XPuvHSEJix9PLtjLTEBVSZIRo2dqLgs6Jq
         woVtQ1dK2nghs1RvBNd3JPLq8D7vPzJbibt2fZrSDLhZNhtwouWQIw1p+DEVeOZ0iFI2
         hwwwnDiFEmMVhTOBoIqaueh0guR+QQpsRcI0EVr50uHhm5BV8426zMjj1DWTy78WWdYd
         NLUckiEvK/9aOREPVYb5wpKh6YQqRP38z8fM8VCvT3pwLVKrs+9SI1s41kGYhNE9UF9k
         gXheHCh6FD+//nBykNdcmWpMhsp91IMye7VskVpA3fh8TyCqKPmKwWfxX7KpicLacTIT
         FVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I9VUcQDpCv1rkzrj2b4j+bs9wnou0NsHbd1posW4klQ=;
        b=7ctck4BqbVvW9tji8ZSn2+ZrJEzVsOX4bfPp/b00SNFtmGaM3aQzjTtXxhRCRK20q8
         1BX9y+DLs7DuResAjhb3VDfcb5KAVUfIzmF53SmA8R6vtsmTYSDhyCKtO1dju9B3g78Y
         1SHeshyRs6GqhswOjn+qxYxy8IgrJqoeoXX1lePkcGZs2plEBYzhl44z/AkuVIpCjd4k
         K+t6+tKS0JPrqPy8qiLGWGB2Xg8YM8UJdfGvudtOzHQlr30A57kYrBHHlUd4EZ3ZVkql
         8A8vaJXKY/AA2WDTJSqT+sy307F6DE2v9Zco7hVrZm0CAih59FnIi6g/Sx+V90mAov9j
         g4xQ==
X-Gm-Message-State: AOAM5334rAk4/S6lUOcEu6VbgKTtRawhzs9jkRhXgtjSv/RYynzk6q8J
        4f//xpwffG/CzW80/HJdh7BtAd3i771J
X-Google-Smtp-Source: ABdhPJwTJSOULKiTw6Uxt86p98cArMvvlW+DgciLnCqZ20mVM7/QJ+j4L1L3R+SfVLClE1quLWFmig==
X-Received: by 2002:a05:6214:20e9:b0:441:527f:dffa with SMTP id 9-20020a05621420e900b00441527fdffamr465580qvk.34.1650055169734;
        Fri, 15 Apr 2022 13:39:29 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id r201-20020a3744d2000000b0069c761b8ad6sm2813478qka.75.2022.04.15.13.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 13:39:28 -0700 (PDT)
Date:   Fri, 15 Apr 2022 16:39:26 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Chris Suter <chris@sutes.me>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Geert Stappers <stappers@stappers.nl>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Fwd: Adding crates
Message-ID: <20220415203926.pvahugtzrg4dbhcc@moria.home.lan>
References: <CAKfU0DLS5icaFn0Mve6+y9Tn1vL+eLKqfquvXbX4oCpYH+VapQ@mail.gmail.com>
 <20220328054136.27mt2xdaltz4unby@gpm.stappers.nl>
 <CAKfU0D+gaC6s6kBBQ9OV+E9PFcm997efY-cUwP3bFWmuDDugbA@mail.gmail.com>
 <YkKXvnsvr0qz/pR2@kroah.com>
 <CAKfU0DLv3K7benXuofXqJwsgxUHA10bu8XWmyBZ0Z_PpZFMACg@mail.gmail.com>
 <CANiq72mrBpJm_6rjapicBoO_mkg4_hEpi9aRTAkj+gtiGkC3Aw@mail.gmail.com>
 <CAKfU0DJ1AqR4cy4=706qRGESozHii9dPL5BYQV047cZkyn3RzA@mail.gmail.com>
 <YkPdIMowqBsJORiK@kroah.com>
 <20220330204353.57w3fxtaw4wwqvi3@moria.home.lan>
 <df41ae9d0f02953cbfe9491f69247a8035f64562.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df41ae9d0f02953cbfe9491f69247a8035f64562.camel@HansenPartnership.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 09:31:24AM -0400, James Bottomley wrote:
> I think the solution to the problem is to try to maintain highly mobile
> reference implementations and also keep constantly considering what the
> requirements are for mobility (both on the part of the reference
> implementation and the kernel).  I also think that if we ever gave
> impementors the magic ability just to dump any old code in the kernel,
> they'd use it to take the lazy way out because it's a lot easier than
> trying to keep the reference implementation separate.
> 
> The fact that most "reference" implementations don't conform to the
> above isn't something we should be encouraging by supplying
> compatibility APIs that paper over the problem and encourage API bloat.

I think it might help if we had a
 - standard set of review guidelines
 - standard workflow

for pulling in (vendoring, however it gets done) code from external
repositories.

Generally what I see in the community is that people do want to support the
kernel better, but then people see things like Greg's response of "don't do
that" and it turns people off. Instead, we could
 - recognize that it's already being done (e.g. with zstd)
 - put some things in writing about how it _should_ be done

This could help a lot with e.g. the way Facebook maintains ZSTD - if we say
"look, we want this code factored out better so we only have to review the stuff
that's relevant" - the engineers generally won't mind doing that work, and now
they'll have something to take to their managers as justification.

Another thing I'd like to see is more of what the RCU folks have done - liburcu
is _amazing_ in that, at least for me, it's been a drop in replacement for the
kernel RCU implementation - and I would imagine it's as much as possible the
same code. A good candidate would be the kernel workqueue code: workqueues are
_great_ and I don't know of anything like them in userspace. That code should be
seeing wider use! And if it was made an external library that was consumed by
both the kernel and userspace, it could be - but it would require buy in from
kernel people.

But as you were saying about Facebook (and I discovered when I was at Google
many moons ago, as a young engineer) - large organizations tend to be insular,
they like te pretend the outside world doesn't exist. The kernel is one such
organization :) We could be a better citizen by encouraging and enabling efforts
such as this.
