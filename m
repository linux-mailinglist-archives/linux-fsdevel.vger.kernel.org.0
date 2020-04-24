Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15BE1B7D63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 20:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgDXSA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 14:00:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35485 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgDXSA2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:00:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id t11so4978965pgg.2;
        Fri, 24 Apr 2020 11:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOhA5kkS2JaSYKAoFpzQMe1eFmxmYMfGK0ET3Fa/QIQ=;
        b=NHYXOSYDYoY/VZ64VekcZgVdJLU7Wi7Lr+FKDAgT1vFqc0s620msHMQy/pO5TvJJai
         8ngbXVU/zTjyBYTGNvqaBEv4olu2Y250vn2j6bxZ1KZ+5vfzL3RmqiRpNKlXNjxyK1Im
         ebh5V7m+NNxP/oexUK0md0Rkw4eDLT/0z2OWZxQL+7OepKEA7wEjMWSojXqtpct5Qf35
         a5hoi1BNo7GX9cc2cpkyeAhYY9O7VAUff08OlSCvKrY/N+AmcNxQGmaJhj8TVh6KWUDp
         laFsrmOZlkKq2nv+kB+4kSa/EZsxccLaZuDLMl4G/j3DHUrXAsYW5n3fWm8Xnce6T3Kg
         bqqw==
X-Gm-Message-State: AGi0PuaLd63dDg4JtVFhRwmLRHlUQQEU2U0pIVWHBQ/Sx9JWcSUn5MUB
        R4Fe0jfMAJabySNUTGOgWus=
X-Google-Smtp-Source: APiQypLAe5sS56YNzPHUE76WrUmAZHWqFUZ4digJx0mOf15BViMD/IQDlV7lREIejskhgzivcBhaXA==
X-Received: by 2002:a63:7805:: with SMTP id t5mr10527111pgc.141.1587751227764;
        Fri, 24 Apr 2020 11:00:27 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q19sm6217968pfh.34.2020.04.24.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 11:00:26 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A6FDD403AB; Fri, 24 Apr 2020 18:00:25 +0000 (UTC)
Date:   Fri, 24 Apr 2020 18:00:25 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
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
Message-ID: <20200424180025.GC11244@42.do-not-panic.com>
References: <20200423203140.19510-1-mcgrof@kernel.org>
 <20200424092119.GA360114@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424092119.GA360114@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 24, 2020 at 11:21:19AM +0200, Greg KH wrote:
> On Thu, Apr 23, 2020 at 08:31:40PM +0000, Luis R. Rodriguez wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Christoph's recent patch "firmware_loader: remove unused exports", which
> > is not merged upstream yet, removed two exported symbols. One is fine to
> > remove since only built-in code uses it but the other is incorrect.
> > 
> > If CONFIG_FW_LOADER=m so the firmware_loader is modular but
> > CONFIG_FW_LOADER_USER_HELPER=y we fail at mostpost with:
> > 
> > ERROR: modpost: "fw_fallback_config" [drivers/base/firmware_loader/firmware_class.ko] undefined!
> > 
> > This happens because the variable fw_fallback_config is built into the
> > kernel if CONFIG_FW_LOADER_USER_HELPER=y always, so we need to grant
> > access to the firmware loader module by exporting it.
> > 
> > Instead of just exporting it as we used to, take advantage of the new
> > kernel symbol namespacing functionality, and export the symbol only to
> > the firmware loader private namespace. This would prevent misuses from
> > other drivers and makes it clear the goal is to keep this private to
> > the firmware loader alone.
> > 
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Fixes: "firmware_loader: remove unused exports"
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  drivers/base/firmware_loader/fallback.c       | 3 +++
> >  drivers/base/firmware_loader/fallback_table.c | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> > index 1e9c96e3ed63..d9ac7296205e 100644
> > --- a/drivers/base/firmware_loader/fallback.c
> > +++ b/drivers/base/firmware_loader/fallback.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/umh.h>
> >  #include <linux/sysctl.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/module.h>
> >  
> >  #include "fallback.h"
> >  #include "firmware.h"
> > @@ -17,6 +18,8 @@
> >   * firmware fallback mechanism
> >   */
> >  
> > +MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);
> > +
> >  extern struct firmware_fallback_config fw_fallback_config;
> >  
> >  /* These getters are vetted to use int properly */
> 
> While nice, that does not fix the existing build error that people are
> having, right?

It does.

> > diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
> > index 0a737349f78f..46a731dede6f 100644
> > --- a/drivers/base/firmware_loader/fallback_table.c
> > +++ b/drivers/base/firmware_loader/fallback_table.c
> > @@ -21,6 +21,7 @@ struct firmware_fallback_config fw_fallback_config = {
> >  	.loading_timeout = 60,
> >  	.old_timeout = 60,
> >  };
> > +EXPORT_SYMBOL_NS_GPL(fw_fallback_config, FIRMWARE_LOADER_PRIVATE);
> 
> 
> How about you send a patch that just reverts the single symbol change
> first, and then a follow-on patch that does this namespace addition.  I
> can queue the first one up now, for 5.7-final, and the second one for
> 5.8-rc1.

Sure.

  Luis
