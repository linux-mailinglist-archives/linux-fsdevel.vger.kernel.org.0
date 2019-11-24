Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE8310835F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfKXNZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 08:25:21 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:53149 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKXNZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 08:25:21 -0500
Received: by mail-wm1-f51.google.com with SMTP id l1so12370514wme.2;
        Sun, 24 Nov 2019 05:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ht9UUup2TX0xxPIbxBhXRv5NvHEMASjnlgsqsYatr+o=;
        b=H8rWUsvsMBuqav+SU6Org6cYDcDduGql7qBv3DIREbCjbkguuCdZJbg07eoz2FkZ8j
         1DQiDcgu/d8GZ9IC740dNmZ2si36Ec8eBQfyVD5daq37++uQprh4G9FPwBooSJ99ydJB
         55nCill72IuyqaE5AWNBeeuYIyZsK5Yy4qsd1Q1avZSp5/eHDIIU7rE+Av1fH+bCWMok
         QR5y9cPLtQcj6jbEqh147d7IhgFLUhKe+y2M+jG2I5DSTiridN+lgUFUQOD7tosuuWzi
         PpQZn7+ITS16YynTnQ5N/vF8dkKHZG+5NNw2GydLnCzP/2f6zi3fyA8T51qmWQdoN63a
         Vm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ht9UUup2TX0xxPIbxBhXRv5NvHEMASjnlgsqsYatr+o=;
        b=kMmIeLTnaKZFk+QQtpNgaagGOnKSTl9ohO4JZA3WakDqEnIFx1mSstYiQCYAS2KvE8
         ZxxatFaA0bpl/LAS8S/B7YcTVobTLz3WWIL3wR2qAAGTA/kqXMpLA+Ti43bkmqS3fbQm
         ItSXM/U+o2O9XHuIVA+NiD5suU4o+BuketFJ/sxWh+peudQYFgDh+yKPsrGzSWdHBBus
         BHQkhQH8SytQVNpHrqyDznCmg+3qLFa/RKGerGipW8O6DS6zv7gB4whSPJs4NTOTDfJz
         6JbQvzQDA7V8owv4OMOZ3GJjlWH8JUIZ0GeeO9fIW/yFvTkRBpIgCK7ljAVu4NMlBsqZ
         PdKg==
X-Gm-Message-State: APjAAAW4ztW+bM8HLV4BGWoY52sSjlFRSqWwU8m1PI3R2gDNjt4JJpgo
        sfrbB13KcgkYuJGNUaFPYg==
X-Google-Smtp-Source: APXvYqw1mBrZte82t9/JtxDM7dPpYmdS4Mj0JsdsJp6Dnodj+0XQp+Q3uvxJ/0KnnAsgZh3kl2DKsw==
X-Received: by 2002:a1c:5415:: with SMTP id i21mr25169901wmb.120.1574601919029;
        Sun, 24 Nov 2019 05:25:19 -0800 (PST)
Received: from avx2 ([46.53.250.34])
        by smtp.gmail.com with ESMTPSA id b2sm6150871wrr.76.2019.11.24.05.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 05:25:18 -0800 (PST)
Date:   Sun, 24 Nov 2019 16:25:13 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH][v4] x86/resctrl: Add task resctrl information display
Message-ID: <20191124132513.GA30453@avx2>
References: <20191122095833.20861-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191122095833.20861-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 22, 2019 at 05:58:33PM +0800, Chen Yu wrote:
> Monitoring tools that want to find out which resctrl control
> and monitor groups a task belongs to must currently read
> the "tasks" file in every group until they locate the process
> ID.
> 
> Add an additional file /proc/{pid}/resctrl to provide this
> information.

> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c

> +		seq_printf(s, "/%s", rdtg->kn->name);
> +		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
> +				    mon.crdtgrp_list) {
> +			if (tsk->rmid != crg->mon.rmid)
> +				continue;
> +			seq_printf(s, "%smon_groups/%s",
> +				   rdtg == &rdtgroup_default ? "" : "/",
> +				   crg->kn->name);
> +			break;
> +		}
> +		seq_puts(s, "\n");

This should be seq_putc().


> --- /dev/null
> +++ b/include/linux/resctrl.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _RESCTRL_H
> +#define _RESCTRL_H
> +
> +#ifdef CONFIG_PROC_CPU_RESCTRL
> +
> +#include <linux/proc_fs.h>

Forward declaring stuff should be more than enough.

> +int proc_resctrl_show(struct seq_file *m,
> +		      struct pid_namespace *ns,
> +		      struct pid *pid,
> +		      struct task_struct *tsk);
> +
> +#endif
> +
> +#endif /* _RESCTRL_H */
