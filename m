Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B990F1CBD0B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 05:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgEIDs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 23:48:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41911 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgEIDs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 23:48:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id r10so1335611pgv.8;
        Fri, 08 May 2020 20:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hD0R4FU5llXtJjcH0Qaw/mWo7Wc3hOPuTzuuFmKSMr4=;
        b=ZS5aG6/1kxOHJXVhz2gu1gmYfrZQameu2SkSkabk8a0F+USyoE1XwtoWcxitMpGYHg
         gm1fHOdgz6LDFLR6Uv8H3OQjMQVB5wextmOFtwDuPAdcRAqSxN7DGSHpTcoUbGGCAyl3
         CPunHkKzxA9vF7hnD2azdaqN8BzhXwSO4sxYgmbIk4CYGC1+SHggL836vlFllTJGeL6w
         U8ay73ewUmf3CyFVJSIPjoVK4JieTWPBRi2ZsZ/mRT8oE2UCMXpaRXKrDPfRB8Td5VZL
         lcKJIaAQeXSyfpAsSaXNogL1eeKuncBCzPgFCsPb3w9QAoEBFGFIMvx7xsP8ODBwl5Jo
         Cu3w==
X-Gm-Message-State: AGi0PuZLIxiurkFf1n0t9/l0bKEUFyVs5qI4Y94dxlK5Rtn+zPBwfgAR
        HudqQ2ox62JOYJcnbjxydWc=
X-Google-Smtp-Source: APiQypJgqquftLfojmRDQ311OD9XhSFj0W23UlCHJWHNlOTbAGa4+b+T6f+86Ay6aZJLvCi5D/41TA==
X-Received: by 2002:a63:dc56:: with SMTP id f22mr4823828pgj.284.1588996137062;
        Fri, 08 May 2020 20:48:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 6sm3199157pfj.123.2020.05.08.20.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 20:48:55 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 642134035F; Sat,  9 May 2020 03:48:54 +0000 (UTC)
Date:   Sat, 9 May 2020 03:48:54 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Tso Ted <tytso@mit.edu>, Adrian Bunk <bunk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jessica Yu <jeyu@suse.de>, Takashi Iwai <tiwai@suse.de>,
        Ann Davis <AnDavis@suse.com>,
        Richard Palethorpe <rpalethorpe@suse.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200509034854.GI11244@42.do-not-panic.com>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507182257.GX11244@42.do-not-panic.com>
 <20200507184307.GF205881@optiplex-lnx>
 <20200507184705.GG205881@optiplex-lnx>
 <20200507203340.GZ11244@42.do-not-panic.com>
 <20200507220606.GK205881@optiplex-lnx>
 <20200507222558.GA11244@42.do-not-panic.com>
 <20200508124719.GB367616@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508124719.GB367616@optiplex-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 08:47:19AM -0400, Rafael Aquini wrote:
> On Thu, May 07, 2020 at 10:25:58PM +0000, Luis Chamberlain wrote:
> > On Thu, May 07, 2020 at 06:06:06PM -0400, Rafael Aquini wrote:
> > > On Thu, May 07, 2020 at 08:33:40PM +0000, Luis Chamberlain wrote:
> > > > I *think* that a cmdline route to enable this would likely remove the
> > > > need for the kernel config for this. But even with Vlastimil's work
> > > > merged, I think we'd want yet-another value to enable / disable this
> > > > feature. Do we need yet-another-taint flag to tell us that this feature
> > > > was enabled?
> > > >
> > > 
> > > I guess it makes sense to get rid of the sysctl interface for
> > > proc_on_taint, and only keep it as a cmdline option. 
> > 
> > That would be easier to support and k3eps this simple.
> > 
> > > But the real issue seems to be, regardless we go with a cmdline-only option
> > > or not, the ability of proc_taint() to set any arbitrary taint flag 
> > > other than just marking the kernel with TAINT_USER. 
> > 
> > I think we would have no other option but to add a new TAINT flag so
> > that we know that the taint flag was modified by a user. Perhaps just
> > re-using TAINT_USER when proc_taint() would suffice.
> >
> 
> We might not need an extra taint flag if, perhaps, we could make these
> two features mutually exclusive. The idea here is that bitmasks added 
> via panic_on_taint get filtered out in proc_taint(), so a malicious 
> user couldn't exploit the latter interface to easily panic the system,
> when the first one is also in use. 

I get it, however I I can still see the person who enables enabling
panic-on-tain wanting to know if proc_taint() was used. So even if
it was not on their mask, if it was modified that seems like important
information for a bug report analysis.

  Luis
