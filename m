Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8CE1E7BDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 13:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgE2Lb3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 07:31:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33691 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgE2Lb2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 07:31:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id t7so1077296plr.0;
        Fri, 29 May 2020 04:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AvsWq7VJa9iiiiZPDt6wxFPuvWXi0S00tNQBgjfRAc8=;
        b=ZVzz1Lg19gQDcsiVKroyT/U5/m2zotloCsaSgRi6nXvynLGxOmAhsNnCu/F/T4esuf
         cUY3qtze2+5YYF3N6nqMj1oNFQgf4J2Vv2DtcsU3oiBLrnOec+QvWjdvR8KaindCPbhH
         m/LsNtlt9WsAxego1wHAYeJXRA2vXlZqqWtECBDQ0PkPmR68o5+5xak7RNDl0XNcCBKw
         JvapGYGEDipc+zOlVpdzEx+On0wcdVDLvmDbj4/T6Ct1K8pk8TVCbk0pNhzImvU6Bibr
         eT+2T3E4Quhpwn4u3eziXf5+jbJb8EXHL9u8q3LVOIxMBMmex2Q1w6DYKS8qc3jYFC2y
         ryiQ==
X-Gm-Message-State: AOAM531eizGZjQvuZkwwWkidXVXUGFYbtDXyiNsmcFZ+UN9QuLo9y7bG
        KHkVD33KofX+p6E8ZtadVJU=
X-Google-Smtp-Source: ABdhPJxXu2aILyEyJN5zSu7sk62ljMBE6JhII699Ncap7at5SV5lLqLusVTid/nX7J2IJ8QVX5BL5Q==
X-Received: by 2002:a17:90a:fa0d:: with SMTP id cm13mr8942222pjb.131.1590751887477;
        Fri, 29 May 2020 04:31:27 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u20sm7238968pfn.144.2020.05.29.04.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 04:31:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D3BC64046C; Fri, 29 May 2020 11:31:24 +0000 (UTC)
Date:   Fri, 29 May 2020 11:31:24 +0000
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
Message-ID: <20200529113124.GZ11244@42.do-not-panic.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
 <1589859071-25898-2-git-send-email-nixiaoming@huawei.com>
 <20200529070903.GV11244@42.do-not-panic.com>
 <3d2d4b2e-db9e-aa91-dd29-e15d24028964@huawei.com>
 <20200529073646.GW11244@42.do-not-panic.com>
 <abdab2be-91e2-5f9b-bf49-abc387072a31@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abdab2be-91e2-5f9b-bf49-abc387072a31@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 04:33:01PM +0800, Xiaoming Ni wrote:
> On 2020/5/29 15:36, Luis Chamberlain wrote:
> > On Fri, May 29, 2020 at 03:27:22PM +0800, Xiaoming Ni wrote:
> > > On 2020/5/29 15:09, Luis Chamberlain wrote:
> > > > On Tue, May 19, 2020 at 11:31:08AM +0800, Xiaoming Ni wrote:
> > > > > --- a/kernel/sysctl.c
> > > > > +++ b/kernel/sysctl.c
> > > > > @@ -3358,6 +3358,25 @@ int __init sysctl_init(void)
> > > > >    	kmemleak_not_leak(hdr);
> > > > >    	return 0;
> > > > >    }
> > > > > +
> > > > > +/*
> > > > > + * The sysctl interface is used to modify the interface value,
> > > > > + * but the feature interface has default values. Even if register_sysctl fails,
> > > > > + * the feature body function can also run. At the same time, malloc small
> > > > > + * fragment of memory during the system initialization phase, almost does
> > > > > + * not fail. Therefore, the function return is designed as void
> > > > > + */
> > > > 
> > > > Let's use kdoc while at it. Can you convert this to proper kdoc?
> > > > 
> > > Sorry, I do n’t know the format requirements of Kdoc, can you give me some
> > > tips for writing?
> > 
> > Sure, include/net/mac80211.h is a good example.
> > 
> > > > > +void __init register_sysctl_init(const char *path, struct ctl_table *table,
> > > > > +				 const char *table_name)
> > > > > +{
> > > > > +	struct ctl_table_header *hdr = register_sysctl(path, table);
> > > > > +
> > > > > +	if (unlikely(!hdr)) {
> > > > > +		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
> > > > > +		return;
> > > > 
> > > > table_name is only used for this, however we can easily just make
> > > > another _register_sysctl_init() helper first, and then use a macro
> > > > which will concatenate this to something useful if you want to print
> > > > a string. I see no point in the description for this, specially since
> > > > the way it was used was not to be descriptive, but instead just a name
> > > > followed by some underscore and something else.
> > > > 
> > > Good idea, I will fix and send the patch to you as soon as possible
> > 
> > No rush :)
> > 
> > > > > +	}
> > > > > +	kmemleak_not_leak(hdr);
> > > > 
> > > > Is it *wrong* to run kmemleak_not_leak() when hdr was not allocated?
> > > > If so, can you fix the sysctl __init call itself?
> > > I don't understand here, do you mean that register_sysctl_init () does not
> > > need to call kmemleak_not_leak (hdr), or does it mean to add check hdr
> > > before calling kmemleak_not_leak (hdr) in sysctl_init ()?
> > 
> > I'm asking that the way you are adding it, you don't run
> > kmemleak_not_leak(hdr) if the hdr allocation filed. If that is
> > right then it seems that sysctl_init() might not be doing it
> > right.
> > 
> > Can that code be shared somehow?
> > 
> >    Luis
> 
> void __ref kmemleak_not_leak(const void *ptr)
> {
> 	pr_debug("%s(0x%p)\n", __func__, ptr);
> 
> 	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> 		make_gray_object((unsigned long)ptr);
> }
> EXPORT_SYMBOL(kmemleak_not_leak);
> 
> In the code of kmemleak_not_leak(), it is verified that the pointer is
> valid, so kmemleak_not_leak (NULL) will not be a problem.
> At the same time, there is no need to call kmemleak_not_leak() in the failed
> branch of register_sysctl_init().

Thanks for the confirmation.

   Luis
