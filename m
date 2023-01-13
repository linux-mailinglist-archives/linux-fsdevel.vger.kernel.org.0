Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FCE66A4BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 22:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjAMVEu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 16:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjAMVEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:04:48 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE0340C17
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 13:04:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so22165472wrz.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBkw8r9CJeekbGYTh36DHrDJzIpEVDx7FXDOscNp7T0=;
        b=WyPZxkCnjCvhkc7g6P86uFd7Fb8vpM3n+uesRUn7HA8lXnCk+hdGRmD74Hd3qClAXr
         99+bPxh5BPIY+5nd+UxvG7gZI3VHQlimSzHRY8BISaJ5z6nUtr0ggkMStscDFaDXSq0/
         HZtoSQ+9i6OEvy8T1lpBvAZHrIsbCuo3VBo8DHE07aSfAsxZkWr9ZSM82WcnHL8/IU+7
         wW5sP73Z218c2PBOjC7ceJcYQ17Ai8Fqg00yKVhmsps7Kcl7kSDJ22J/BYG6kgXUoCX3
         SPnBNs5lAtwIIAsVOETmC+kMYcKXJ0Sz1psnV9snUHQEbeOMD/eW+0bLI0s/jZiAZEMU
         C5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBkw8r9CJeekbGYTh36DHrDJzIpEVDx7FXDOscNp7T0=;
        b=smUW26J0MIAODD4kMEOh5LVWSK0qiClcn6b9A1REXyNTSUk3utSFKPbmLqaAeCRqJ7
         QM0stIoScJVXsnI7Q3+l/c9OYoxV68sSUjEvCR+U5wiKgd7XhL9nEeTtqUVSvaRL6YIe
         X3Artc/mFNRkOyLpM3bcwoxgQt3ZancPyMxSVEn6xRwo8nB0SVUZDULQHeqhCY0tgfqb
         qOBj835gt71R3T9lxgixN2fkxfY1qjZyhvay/Z6moK9Rok8FgLYxP4kVBYv+JPtq4Nnq
         8rgFLAIQEGw7i7TZRertklA56N2+ddYNbaCWSOzIjp4teRe9FRenWAWau9VyYgKcFYud
         7W1A==
X-Gm-Message-State: AFqh2kqcoxkp9iNl1ywsFcvndsGgfLFYacoytL3ilb0+gZBWpeIJLaal
        XDnJHwVzBEkFGfJ12xQEo7J4RQ==
X-Google-Smtp-Source: AMrXdXtwPD0oKfV/V27AA18FKeuh/Wrgr9AuHTthzJvrbTN11U5FDTWCtGDza5FMagq10S7IxYI3KA==
X-Received: by 2002:adf:e647:0:b0:236:6c33:2130 with SMTP id b7-20020adfe647000000b002366c332130mr665230wrn.68.1673643885754;
        Fri, 13 Jan 2023 13:04:45 -0800 (PST)
Received: from smtpclient.apple (global-5-143.n-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d678b000000b0029e1aa67fd2sm1998172wru.115.2023.01.13.13.04.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2023 13:04:45 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: ia64 removal (was: Re: lockref scalability on x86-64 vs
 cpu_relax)
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <SJ1PR11MB60832EF4EA3D528533100F8DFCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
Date:   Fri, 13 Jan 2023 21:04:44 +0000
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
Content-Transfer-Encoding: 7bit
Message-Id: <53F2E30D-FE1D-4710-B5FC-049905A7158E@jrtc27.com>
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
 <SJ1PR11MB6083368BCA43E5B0D2822FD3FCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
 <Y8HDzzDaP5uY0v8K@Jessicas-MacBook-Pro>
 <SJ1PR11MB60832EF4EA3D528533100F8DFCC29@SJ1PR11MB6083.namprd11.prod.outlook.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13 Jan 2023, at 21:03, Luck, Tony <tony.luck@intel.com> wrote:
> 
>> For what it's worth, Debian and Gentoo both have ia64 ports with active
>> users (6.1 looks like it currently fails to build in Debian due to a
>> minor packaging issue, but various versions of 6.0 were built and
>> published, and one of those is running on the one ia64 Debian builder I
>> personally have access to).
> 
> Jess,
> 
> So dropping ia64 from the upstream kernel won't just save time of kernel
> developers. It will also save time for the folks keeping Debian and Gentoo
> ports up and running.
> 
> Are there people actually running production systems on ia64 that also
> update to v6.x kernels?
> 
> If so, why? Just scrap the machine and replace with almost anything else.
> You'll cover the cost of the new machine in short order with the savings on
> your power bill.

Hobbyists, same as alpha, hppa, m68k, sh and any other such
architectures that have no real use in this day and age.

Jess

