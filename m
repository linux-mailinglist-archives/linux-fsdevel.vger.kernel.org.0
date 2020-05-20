Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB81DA745
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 03:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgETBjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 21:39:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41148 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETBjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 21:39:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so785089pfy.8;
        Tue, 19 May 2020 18:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ID/ccNFq5wKcWBo+XOGOt9X+x6/9v2LB7jQF/7sjFA=;
        b=fqloFST95LDPRWpS5wTbesdtaIXUGbIBU0di7TGdkJg/Gg7BQTYHOOuppzIwPWVgTc
         Oy99NivSWOfUgczINCqQGbRI7mTS09nDZxcDC3YHoZt1dCIIpo6w1ZYtnOEbXJce9TKT
         DJtuayo52t9QInc911cRY2QWQ4TAjHhX1lDbnMa0x7bal+IdeyvVT3GSmxFkBHY1U12x
         CdyQrj97kCvz5csCurspFW8BrjkXZ1z+gVJUDFjRLAckN3L3MWawgRbFojvioHiDIby6
         nnu+1xMcqOp0VLkLFLxtQLdFPkyv7ZQ5ZkZ39SG2oh5Ei8K5M0JJbjefPEIAgxWBw8kM
         6uXw==
X-Gm-Message-State: AOAM531uHCEkw3SKXO2jculyXknhEp1dWqtxkpPU8wP2okWWZIF/Vz15
        Y6SVstHy5jtBlZEDYrP/jGQ=
X-Google-Smtp-Source: ABdhPJy+lLjCnNCAYlDgP2k5MqVm9vO8gOr9gbhfRqRz4WxXcrnXH1IdAtKHPnRnbX2t9GCeMuYFUg==
X-Received: by 2002:a62:e219:: with SMTP id a25mr1875818pfi.303.1589938791597;
        Tue, 19 May 2020 18:39:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g17sm516795pgg.43.2020.05.19.18.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 18:39:50 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 694AB4088B; Wed, 20 May 2020 01:39:49 +0000 (UTC)
Date:   Wed, 20 May 2020 01:39:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        keescook@chromium.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, gpiccoli@canonical.com, rdna@fb.com,
        patrick.bellasi@arm.com, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        tglx@linutronix.de, peterz@infradead.org,
        Jisheng.Zhang@synaptics.com, khlebnikov@yandex-team.ru,
        bigeasy@linutronix.de, pmladek@suse.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com, alex.huangjianhui@huawei.com
Subject: Re: [PATCH v4 2/4] sysctl: Move some boundary constants form
 sysctl.c to sysctl_vals
Message-ID: <20200520013949.GV11244@42.do-not-panic.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
 <1589859071-25898-3-git-send-email-nixiaoming@huawei.com>
 <1bf1aefb-adfd-4f43-35c7-5b320d43faf8@i-love.sakura.ne.jp>
 <550a55b8-d2a8-0de3-0bed-8f93a4513efe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550a55b8-d2a8-0de3-0bed-8f93a4513efe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 09:14:08AM +0800, Xiaoming Ni wrote:
> On 2020/5/19 12:44, Tetsuo Handa wrote:
> > On 2020/05/19 12:31, Xiaoming Ni wrote:
> > > Some boundary (.extra1 .extra2) constants (E.g: neg_one two) in
> > > sysctl.c are used in multiple features. Move these variables to
> > > sysctl_vals to avoid adding duplicate variables when cleaning up
> > > sysctls table.
> > > 
> > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> > I feel that it is use of
> > 
> > 	void *extra1;
> > 	void *extra2;
> > 
> > in "struct ctl_table" that requires constant values indirection.
> > Can't we get rid of sysctl_vals using some "union" like below?
> > 
> > struct ctl_table {
> > 	const char *procname;           /* Text ID for /proc/sys, or zero */
> > 	void *data;
> > 	int maxlen;
> > 	umode_t mode;
> > 	struct ctl_table *child;        /* Deprecated */
> > 	proc_handler *proc_handler;     /* Callback for text formatting */
> > 	struct ctl_table_poll *poll;
> > 	union {
> > 		void *min_max_ptr[2];
> > 		int min_max_int[2];
> > 		long min_max_long[2];
> > 	};
> > } __randomize_layout;
> > 
> > .
> > 
> 
> net/decnet/dn_dev.c:
> static void dn_dev_sysctl_register(struct net_device *dev, struct
> dn_dev_parms *parms)
> {
> 	struct dn_dev_sysctl_table *t;
> 	int i;
> 
> 	char path[sizeof("net/decnet/conf/") + IFNAMSIZ];
> 
> 	t = kmemdup(&dn_dev_sysctl, sizeof(*t), GFP_KERNEL);
> 	if (t == NULL)
> 		return;
> 
> 	for(i = 0; i < ARRAY_SIZE(t->dn_dev_vars) - 1; i++) {
> 		long offset = (long)t->dn_dev_vars[i].data;
> 		t->dn_dev_vars[i].data = ((char *)parms) + offset;
> 	}
> 
> 	snprintf(path, sizeof(path), "net/decnet/conf/%s",
> 		dev? dev->name : parms->name);
> 
> 	t->dn_dev_vars[0].extra1 = (void *)dev;
> 
> 	t->sysctl_header = register_net_sysctl(&init_net, path, t->dn_dev_vars);
> 	if (t->sysctl_header == NULL)
> 		kfree(t);
> 	else
> 		parms->sysctl = t;
> }
> 
> A small amount of code is not used as a boundary value when using extra1.
> This scenario may not be suitable for renaming to min_max_ptr.
> 
> Should we add const to extra1 extra2 ?
> 
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -124,8 +124,8 @@ struct ctl_table {
>         struct ctl_table *child;        /* Deprecated */
>         proc_handler *proc_handler;     /* Callback for text formatting */
>         struct ctl_table_poll *poll;
> -       void *extra1;
> -       void *extra2;
> +       const void *extra1;
> +       const void *extra2;
>  } __randomize_layout;

Do that, compile an allyesconfig and it'll fail, but if you fix the
callers so that they use a const, then yes. That would cover only your
architecture. It is unclear if we ever used non-const for this on purpose.

  Luis
