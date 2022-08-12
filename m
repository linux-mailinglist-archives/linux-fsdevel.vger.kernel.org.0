Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96B5591597
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Aug 2022 20:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239348AbiHLSoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Aug 2022 14:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiHLSoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:44:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13201B3B35
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 11:44:23 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso9094615pjq.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=L2TciKx1WlWZUXIBx3BZfiDv3QIF+HKgV/k31Rn9huY=;
        b=jQOhU4/QHuS3o93vFsm50IV+cq38CYO6JOw/Jif8m4Lx4eOz+PJKsvM+Ym8ZyDrJ/a
         12qL368nG8+XLHaEk4H1NLdZ4flevHmP6wLGKlQlRM1mpFXqQVSClglcwMP8ahcSuipX
         cVSkhe+ZBEGTCpJd2O0E29jvp7Gtm8trBwRIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=L2TciKx1WlWZUXIBx3BZfiDv3QIF+HKgV/k31Rn9huY=;
        b=wpTc3FfyV1JRp2dxWg5pb7c8GYVd1Cc5G+D63i8oNCoRQU8ZKuNBGZHjUjGkEZAuh2
         xFIYCDo4x4l2eu9kcS6CXo/6bNS9Ld74i7EQramYc1UH1u0RfLVXJU3rp7GZCu1LDoX2
         NbCKpGWbBA8vmDZYrSTAad3UggJhKMZGlDt8XNX7ARHS3j991egu7bynccR+Ii8ry6ST
         f2mCCjpIowAn29V7jLu02vakXyxt9SZZ6yAzmPBFJ+F6alvVSxrgPpodfdn5ICP4ISxg
         Z20dKkEt46JJu6WwBGTDGNq4hMvUDgnCyUxfHEqmboi3UPZS3HdtX0jHif22bSWCsSsY
         OY4Q==
X-Gm-Message-State: ACgBeo2TkxqC+16+e8wCshyx+HVaHSol6HTMnYgCyEaYzSFNyDRkm7k7
        eJaFXMcVwxIjPTnLJkGqDgEn/w==
X-Google-Smtp-Source: AA6agR5WSvcFgKv2uKPXKT0DjScHXffhB2fOu7jYvSJHq8Skop1Bd+xq7Z2ahtA73Qn4kTjEukIDLw==
X-Received: by 2002:a17:902:f787:b0:16a:1e2b:e97 with SMTP id q7-20020a170902f78700b0016a1e2b0e97mr5174519pln.27.1660329862540;
        Fri, 12 Aug 2022 11:44:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u5-20020a62d445000000b0052895642037sm1932056pfl.139.2022.08.12.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 11:44:21 -0700 (PDT)
Date:   Fri, 12 Aug 2022 11:44:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        syzbot <syzbot+3250d9c8925ef29e975f@syzkaller.appspotmail.com>
Subject: Re: [syzbot] linux-next boot error: BUG: unable to handle kernel
 paging request in kernel_execve
Message-ID: <202208121143.C014AEF0AA@keescook>
References: <0000000000008c0ba505e5f22066@google.com>
 <202208110830.8F528D6737@keescook>
 <YvU+0UHrn9Ab4rR8@iweiny-desk3>
 <YvVPtuel8NMmiTKk@iweiny-desk3>
 <202208111356.97951D32@keescook>
 <YvWaqhLGsBp9ynIq@iweiny-desk3>
 <CACT4Y+bBNJsFobK28impL5bPGE9meQt-RE6xyDF=yxsmcR8ySw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bBNJsFobK28impL5bPGE9meQt-RE6xyDF=yxsmcR8ySw@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 12, 2022 at 11:29:44AM +0200, Dmitry Vyukov wrote:
> On Fri, 12 Aug 2022 at 02:11, Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Thu, Aug 11, 2022 at 02:00:59PM -0700, Kees Cook wrote:
> > > On Thu, Aug 11, 2022 at 11:51:34AM -0700, Ira Weiny wrote:
> > > > On Thu, Aug 11, 2022 at 10:39:29AM -0700, Ira wrote:
> > > > > On Thu, Aug 11, 2022 at 08:33:16AM -0700, Kees Cook wrote:
> > > > > > Hi Fabio,
> > > > > >
> > > > > > It seems likely that the kmap change[1] might be causing this crash. Is
> > > > > > there a boot-time setup race between kmap being available and early umh
> > > > > > usage?
> > > > >
> > > > > I don't see how this is a setup problem with the config reported here.
> > > > >
> > > > > CONFIG_64BIT=y
> > > > >
> > > > > ...and HIGHMEM is not set.
> > > > > ...and PREEMPT_RT is not set.
> > > > >
> > > > > So the kmap_local_page() call in that stack should be a page_address() only.
> > > > >
> > > > > I think the issue must be some sort of race which was being prevented because
> > > > > of the preemption and/or pagefault disable built into kmap_atomic().
> > > > >
> > > > > Is this reproducable?
> > > > >
> > > > > The hunk below will surely fix it but I think the pagefault_disable() is
> > > > > the only thing that is required.  It would be nice to test it.
> > > >
> > > > Fabio and I discussed this.  And he also mentioned that pagefault_disable() is
> > > > all that is required.
> > >
> > > Okay, sounds good.
> > >
> > > > Do we have a way to test this?
> > >
> > > It doesn't look like syzbot has a reproducer yet, so its patch testing
> > > system[1] will not work. But if you can send me a patch, I could land it
> > > in -next and we could see if the reproduction frequency drops to zero.
> > > (Looking at the dashboard, it's seen 2 crashes, most recently 8 hours
> > > ago.)
> >
> > Patch sent.
> >
> > https://lore.kernel.org/lkml/20220812000919.408614-1-ira.weiny@intel.com/

Thank you!

> >
> > But I'm more confused after looking at this again.
> 
> There is splat of random crashes in linux-next happened at the same time:
> 
> https://groups.google.com/g/syzkaller-bugs/search?q=%22linux-next%20boot%20error%3A%22
> 
> There are 10 different crashes in completely random places.
> I would assume they have the same root cause, some silent memory
> corruption or something similar.

Yeah, I noticed the crashes stopped "on their own", so I think I'll
wait a bit more, and if it start back up, we can try Ira's patch, though
I'd agree with the assessment that it looks like it shouldn't be needed.

-Kees

-- 
Kees Cook
