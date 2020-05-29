Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26C31E76C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 09:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgE2Hgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 03:36:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34096 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgE2Hgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 03:36:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id m1so1028513pgk.1;
        Fri, 29 May 2020 00:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e/Dq53c8uDy6FXsZCkAfA0J4N/qAFegmUO6SfVHHBbk=;
        b=sXitWiUD1nf2jHOY6KDectVpwrJMzz45xIsQdeVlc8SzI1WyaK1s77O+/9o9VYBePy
         lhDw0s9Ck5hwXJLcfAb34bdX9YwqAVIz2uh259Ajj8TjN+TRMEn+nfTjQpWwNwTjwtp1
         FPTCNRcdV7sZTqLW6lYZtzeL5SkAx1/9AILBoadmtbf/4QtFPjD+9JzseSsXOf5FXRiL
         EeAKC5DdjfSB2fgZm8ZkFdeH5Dr0O31ZgOeK06RPQXuvOY7JkV22hQzSVR1wrk/KMjCB
         YNAl/TDZPfCqk9XLtts6oiUgET+LAAW5WHA0ShU+tGkgmhiHE2tcpYbAl20H7357GNyk
         IcYg==
X-Gm-Message-State: AOAM530Y6I2I4Tzwx+DRfEQvY87k3uazKxrzBH4U7cOUyYXuMXW7rSQA
        LAbyqY5dZGIEFRLHoqw4Sak=
X-Google-Smtp-Source: ABdhPJzLyyoab/Jq8rDy/ilcEU+5Ad5PE/VwdJ24NfW+vJHD7/Lb+0gPTdYLr8bk8o9PYRtVGmsdoQ==
X-Received: by 2002:a65:5206:: with SMTP id o6mr6779108pgp.16.1590737808812;
        Fri, 29 May 2020 00:36:48 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q100sm7136958pjc.11.2020.05.29.00.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:36:47 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DA81940605; Fri, 29 May 2020 07:36:46 +0000 (UTC)
Date:   Fri, 29 May 2020 07:36:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     keescook@chromium.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, gpiccoli@canonical.com, rdna@fb.com,
        patrick.bellasi@arm.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, mhocko@suse.com,
        penguin-kernel@i-love.sakura.ne.jp, vbabka@suse.cz,
        tglx@linutronix.de, peterz@infradead.org,
        Jisheng.Zhang@synaptics.com, khlebnikov@yandex-team.ru,
        bigeasy@linutronix.de, pmladek@suse.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com, alex.huangjianhui@huawei.com
Subject: Re: [PATCH v4 1/4] sysctl: Add register_sysctl_init() interface
Message-ID: <20200529073646.GW11244@42.do-not-panic.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
 <1589859071-25898-2-git-send-email-nixiaoming@huawei.com>
 <20200529070903.GV11244@42.do-not-panic.com>
 <3d2d4b2e-db9e-aa91-dd29-e15d24028964@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d2d4b2e-db9e-aa91-dd29-e15d24028964@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 03:27:22PM +0800, Xiaoming Ni wrote:
> On 2020/5/29 15:09, Luis Chamberlain wrote:
> > On Tue, May 19, 2020 at 11:31:08AM +0800, Xiaoming Ni wrote:
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -3358,6 +3358,25 @@ int __init sysctl_init(void)
> > >   	kmemleak_not_leak(hdr);
> > >   	return 0;
> > >   }
> > > +
> > > +/*
> > > + * The sysctl interface is used to modify the interface value,
> > > + * but the feature interface has default values. Even if register_sysctl fails,
> > > + * the feature body function can also run. At the same time, malloc small
> > > + * fragment of memory during the system initialization phase, almost does
> > > + * not fail. Therefore, the function return is designed as void
> > > + */
> > 
> > Let's use kdoc while at it. Can you convert this to proper kdoc?
> > 
> Sorry, I do n’t know the format requirements of Kdoc, can you give me some
> tips for writing?

Sure, include/net/mac80211.h is a good example.

> > > +void __init register_sysctl_init(const char *path, struct ctl_table *table,
> > > +				 const char *table_name)
> > > +{
> > > +	struct ctl_table_header *hdr = register_sysctl(path, table);
> > > +
> > > +	if (unlikely(!hdr)) {
> > > +		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
> > > +		return;
> > 
> > table_name is only used for this, however we can easily just make
> > another _register_sysctl_init() helper first, and then use a macro
> > which will concatenate this to something useful if you want to print
> > a string. I see no point in the description for this, specially since
> > the way it was used was not to be descriptive, but instead just a name
> > followed by some underscore and something else.
> > 
> Good idea, I will fix and send the patch to you as soon as possible

No rush :)

> > > +	}
> > > +	kmemleak_not_leak(hdr);
> > 
> > Is it *wrong* to run kmemleak_not_leak() when hdr was not allocated?
> > If so, can you fix the sysctl __init call itself?
> I don't understand here, do you mean that register_sysctl_init () does not
> need to call kmemleak_not_leak (hdr), or does it mean to add check hdr
> before calling kmemleak_not_leak (hdr) in sysctl_init ()?

I'm asking that the way you are adding it, you don't run
kmemleak_not_leak(hdr) if the hdr allocation filed. If that is
right then it seems that sysctl_init() might not be doing it
right.

Can that code be shared somehow?

  Luis
