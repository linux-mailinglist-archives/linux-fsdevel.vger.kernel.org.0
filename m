Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9177983045
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 13:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbfHFLHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 07:07:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37839 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfHFLHs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:07:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so41316496pfa.4;
        Tue, 06 Aug 2019 04:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tBmS1JSg6R7dIdS7tcKHXNzn/jUBrwmVmbb/LUzYkA4=;
        b=FKiohG4pWZeA/Wi7DBC/9npqkDrHpyRoEZz0rJr3UUucKs69b2m0OSmC0nKoqoEBW7
         5a5fisl81W7ayWltjhWVDhYcauX5oI8qjT4HtPAD8MYvTTn2BUR7Z+/ra9jmsBm5ygxl
         coLvx5hCepcasDv3Ne7A33Zn9x+18/WPTkwpxyTWKXEQavMv1FfQZWEk9n3vFCWxJKBz
         8xgjqJToD3aUbClZjNybApCSYfWR+J9s7Cr5z2gCs2zn7kfaA/XDfENps51XKzcC7h+v
         MMuNw3N9Qr5VXXVcVPES+JzklSH8uO3a+z/VBP70OotlcR+ykPpu1CCL5PGcPfSbf/4h
         l5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tBmS1JSg6R7dIdS7tcKHXNzn/jUBrwmVmbb/LUzYkA4=;
        b=n46lLmHUD02u+QOH8gDUai8ueLbAFlpSYO8K/nCKYO3wW/pzFwpn7wHPeE03XzaY1A
         y3LxlscdgWZeYcl9V1NZa1R+BX33QRHMRdNa/5TasbN3dKiOpeefEjHtsGsHidi/u+sP
         Q4B64GeQzjdh7+8D4gzCvqk/eGcYKRxQta3U99wbp3pipxF9rQGoqpCYxguqBBvAgLpt
         9xBb0/x+mFT2NeR7bLhHpCKdA71crke1AGlY1h0Labj0lJClFn8+H4SkXywmG/YBeIZr
         Gr+/B1Dac75riAfylY+PdRBOEqycsJDqyJC3IGLSvWM58msxjGTbBTJ+6+DP2LN9Fwim
         qMwQ==
X-Gm-Message-State: APjAAAVehhtL+8+HYdXUWxAQjhF7lJWprQ+P1magMdYfeovNdIttr39w
        h5ZitJkQK/qwjhRT3Zcwfwo=
X-Google-Smtp-Source: APXvYqyN06dee+YCHt2A2RzCyf1hHdHxVyVKw3mol+ZH/H3Wfu7dAX7tuJm7I+hqEodTVg3369khvw==
X-Received: by 2002:a62:3895:: with SMTP id f143mr3075201pfa.116.1565089667635;
        Tue, 06 Aug 2019 04:07:47 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id h129sm82492287pfb.110.2019.08.06.04.07.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 04:07:46 -0700 (PDT)
Date:   Tue, 6 Aug 2019 20:07:37 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        paulmck@linux.ibm.com, Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 3/5] [RFC] arm64: Add support for idle bit in swap PTE
Message-ID: <20190806110737.GB32615@google.com>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-3-joel@joelfernandes.org>
 <20190806084203.GJ11812@dhcp22.suse.cz>
 <20190806103627.GA218260@google.com>
 <20190806104755.GR11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806104755.GR11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 12:47:55PM +0200, Michal Hocko wrote:
> On Tue 06-08-19 06:36:27, Joel Fernandes wrote:
> > On Tue, Aug 06, 2019 at 10:42:03AM +0200, Michal Hocko wrote:
> > > On Mon 05-08-19 13:04:49, Joel Fernandes (Google) wrote:
> > > > This bit will be used by idle page tracking code to correctly identify
> > > > if a page that was swapped out was idle before it got swapped out.
> > > > Without this PTE bit, we lose information about if a page is idle or not
> > > > since the page frame gets unmapped.
> > > 
> > > And why do we need that? Why cannot we simply assume all swapped out
> > > pages to be idle? They were certainly idle enough to be reclaimed,
> > > right? Or what does idle actualy mean here?
> > 
> > Yes, but other than swapping, in Android a page can be forced to be swapped
> > out as well using the new hints that Minchan is adding?
> 
> Yes and that is effectivelly making them idle, no?

1. mark page-A idle which was present at that time.
2. run workload
3. page-A is touched several times
4. *sudden* memory pressure happen so finally page A is finally swapped out
5. now see the page A idle - but it's incorrect.
