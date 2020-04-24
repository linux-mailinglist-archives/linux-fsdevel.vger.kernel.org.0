Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A271B6B5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 04:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgDXCbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 22:31:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34723 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDXCbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:31:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id s10so3215570plr.1;
        Thu, 23 Apr 2020 19:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U+6HKpnLQqwDWAWDyAUFzSdc4+bit2aH/XjnSyxsqnQ=;
        b=VmSAyJOiHcPO2GtunAZZnnt+AEhpj9BKr4SiqtIi8T7LwUmh2QgfTsDOGLisdQgHRn
         wVq6olm2FS/xyiCObleCQujGOhA0DBIdPJM+zOaj6E478SBAwRImKyDw+3HlROsrHx84
         lMYPj/eKWv6i2FJDT+I8xipjDAdRTwH05hF0gqFNMHotlmSBnuQPrbHvWpwnSEsDnJxG
         gUQeeIMNlzGVLP/yH4zHSmBZka6aLu+Kx4N/p5obK9i6XHPF38lWI0K2EcSbTopvBJix
         2A8IoU1sxm7ZlURd8S3+DdErwLhrSl56E8zGaIwAh3PwVr26jM+0jbUeqRpIvKeGn8TN
         RJSQ==
X-Gm-Message-State: AGi0PubspXycCKLqBaeyPTsqHW0ihVa1xczlg8VC1+WxtCqG6UZ/ttym
        yyIg6DwSzXxbW1gJX/ZdoOA=
X-Google-Smtp-Source: APiQypIqUnp8nc2uTmNPWwj0HzyzkCsnMgdSQD41MO+clcq5Xuw3xfrpphVRLFXgHknVo1XpyLQQ+Q==
X-Received: by 2002:a17:90a:2ac2:: with SMTP id i2mr3894231pjg.91.1587695470648;
        Thu, 23 Apr 2020 19:31:10 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w11sm3935002pfq.100.2020.04.23.19.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 19:31:09 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7C447402A1; Fri, 24 Apr 2020 02:31:08 +0000 (UTC)
Date:   Fri, 24 Apr 2020 02:31:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jakub Kicinski <kubakici@wp.pl>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        josh@joshtriplett.org, rishabhb@codeaurora.org, maco@android.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linux-wireless@vger.kernel.org,
        keescook@chromium.org, shuah@kernel.org, mfuzzey@parkeon.com,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com,
        pali.rohar@gmail.com, tiwai@suse.de, arend.vanspriel@broadcom.com,
        zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] firmware_loader: re-export fw_fallback_config into
 firmware_loader's own namespace
Message-ID: <20200424023108.GA11244@42.do-not-panic.com>
References: <20200423203140.19510-1-mcgrof@kernel.org>
 <20200423180544.60d12af0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20200424021420.GZ11244@42.do-not-panic.com>
 <20200423192716.2c32f5dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423192716.2c32f5dd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 07:27:16PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Apr 2020 02:14:20 +0000 Luis Chamberlain wrote:
> > On Thu, Apr 23, 2020 at 06:05:44PM -0700, Jakub Kicinski wrote:
> > > On Thu, 23 Apr 2020 20:31:40 +0000 Luis R. Rodriguez wrote:  
> > > > From: Luis Chamberlain <mcgrof@kernel.org>
> > > > 
> > > > Christoph's recent patch "firmware_loader: remove unused exports", which
> > > > is not merged upstream yet, removed two exported symbols. One is fine to
> > > > remove since only built-in code uses it but the other is incorrect.
> > > > 
> > > > If CONFIG_FW_LOADER=m so the firmware_loader is modular but
> > > > CONFIG_FW_LOADER_USER_HELPER=y we fail at mostpost with:
> > > > 
> > > > ERROR: modpost: "fw_fallback_config" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> > > > 
> > > > This happens because the variable fw_fallback_config is built into the
> > > > kernel if CONFIG_FW_LOADER_USER_HELPER=y always, so we need to grant
> > > > access to the firmware loader module by exporting it.
> > > > 
> > > > Instead of just exporting it as we used to, take advantage of the new
> > > > kernel symbol namespacing functionality, and export the symbol only to
> > > > the firmware loader private namespace. This would prevent misuses from
> > > > other drivers and makes it clear the goal is to keep this private to
> > > > the firmware loader alone.
> > > > 
> > > > Cc: Christoph Hellwig <hch@lst.de>
> > > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Fixes: "firmware_loader: remove unused exports"  
> > > 
> > > Can't help but notice this strange form of the Fixes tag, is it
> > > intentional?  
> > 
> > Yeah, no there is no commit for the patch as the commit is ephemeral in
> > a development tree not yet upstream, ie, not on Linus' tree yet. Using a
> > commit here then makes no sense unless one wants to use a reference
> > development tree in this case, as development trees are expected to
> > rebase to move closer towards Linus' tree. When a tree rebases, the
> > commit IDs change, and this is why the commit is ephemeral unless
> > one uses a base tree / branch / tag.
> 
> I'd think that either the commit is rebase-able and the fix can be
> squashed into it, or it's not and it has a stable commit id. 
> But I guess it may get tricky around the edges..

I'll let Greg decide ;)

I did my part.

  Luis
