Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B4766A46A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 21:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjAMUta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 15:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAMUtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:49:24 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E766C04C
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 12:49:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso15245297wmq.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 12:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0IXTHEul8oECO64H+NEFJZ1qZc9qTDXKUg0Yyv928s=;
        b=FgOZvqmOpohh4tjpZEZ9CiXUhhr3LLBo4dA48IAxIhLjKRNzLWoSQGdQupZwZx2+a1
         krXP+VtZRNcB7GdHtr2PG0P3jgzQePGUseTXsfRp63ZbvZrp3Uc4XpYCnS+LP25dkZ95
         p23CNG08OAxRnyAA4EJAYVI7OunGePsBP7doUFtPkM/gwzG1jmPaXc5ciDagQnOdy4wy
         s9Sa1gFTXJPk0ZL7UYSYgCifwD6RXePFjLOyq/KA+KXtX3WgO+LtEXPNys/DXTZsRmtj
         U9g4CIIQ3CHJVwjfO9xX40BkGLMqo04IhX8m8rqajPn9yoEJ/r4y4Z3HBd5RZ3P5EAz/
         yWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0IXTHEul8oECO64H+NEFJZ1qZc9qTDXKUg0Yyv928s=;
        b=UI6wr0Vh0nZxM7Iey5QavWAzeSNt6cSrV/rpEsnjjMhaRzecdiZ7NeCq+T+95RQ2k4
         3URB+02FbGs/thJGftj+8q9UhdfgivSRyw9zYW1wYwweYR+PvueHxuPFUNju1BNdgBiT
         J0gE+VzOsyqQaiRyLPB61fvJeNxaBPXtaUfTuCJHlxnQ2xvwr7tnTmCWMhr+W+325UIc
         asfuGoaijvpFUZXaL/2urGxXAwejGke8eKbSSTZkLRhi7v95uAGdhXjBOj6csg6ZW2R0
         6ZNDER2tG4F8wxwSDv93Ndjl4fEN0UgIIQdHOPPCBdkzA2so8jGGDrFq5zkj+9hQNx3W
         QA3Q==
X-Gm-Message-State: AFqh2krGmDW92vTcHUfj5zZcknA2QzOfpZcCkjEl1jvqsdnFmVteEqlc
        FdUsxbTB7Emq43L1deyYZ6RCrQ==
X-Google-Smtp-Source: AMrXdXt9VkcefpvBZsD3+f4QlFMXVMwT0tj/VKStUIzMmlGFyYGBNJWbiXy0v10sDYiPsjjqoZs3lw==
X-Received: by 2002:a05:600c:2318:b0:3c6:e63e:23e9 with SMTP id 24-20020a05600c231800b003c6e63e23e9mr62275003wmo.24.1673642961366;
        Fri, 13 Jan 2023 12:49:21 -0800 (PST)
Received: from Jessicas-MacBook-Pro.localdomain (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id e18-20020a05600c4e5200b003d9876aa04asm30903605wmq.41.2023.01.13.12.49.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Jan 2023 12:49:20 -0800 (PST)
Received: by Jessicas-MacBook-Pro.localdomain (Postfix, from userid 501)
        id 2689A4823B3E; Fri, 13 Jan 2023 20:49:19 +0000 (GMT)
Date:   Fri, 13 Jan 2023 20:49:19 +0000
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: ia64 removal (was: Re: lockref scalability on x86-64 vs
 cpu_relax)
Message-ID: <Y8HDzzDaP5uY0v8K@Jessicas-MacBook-Pro>
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
 <SJ1PR11MB6083368BCA43E5B0D2822FD3FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 08:55:41AM +0100, Ard Biesheuvel wrote:
> On Fri, 13 Jan 2023 at 01:31, Luck, Tony <tony.luck@intel.com> wrote:
> >
> > > Yeah, if it was ia64-only, it's a non-issue these days. It's dead and
> > > in pure maintenance mode from a kernel perspective (if even that).
> >
> > There's not much "simultaneous" in the SMT on ia64. One thread in a
> > spin loop will hog the core until the h/w switches to the other thread some
> > number of cycles (hundreds, thousands? I really can remember). So I
> > was pretty generous with dropping cpu_relax() into any kind of spin loop.
> >
> > Is it time yet for:
> >
> > $ git rm -r arch/ia64
> >
> 
> Hi Tony,
> 
> Can I take that as an ack on [0]? The EFI subsystem has evolved
> substantially over the years, and there is really no way to do any
> IA64 testing beyond build testing, so from that perspective, dropping
> it entirely would be welcomed.

For what it's worth, Debian and Gentoo both have ia64 ports with active
users (6.1 looks like it currently fails to build in Debian due to a
minor packaging issue, but various versions of 6.0 were built and
published, and one of those is running on the one ia64 Debian builder I
personally have access to).

Jess
