Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705EE36AA73
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 03:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhDZBtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Apr 2021 21:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhDZBtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:49:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC6CC061760
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Apr 2021 18:48:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so4218892pjj.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Apr 2021 18:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=yjddGSgjNoB5y1kSapRuBtROwu0My00oEQswcqrZTOk=;
        b=BekNpRLMi9FI8lqejNA/kp83jdzG17igVs9SpF0PYEW29tM9UMPOS+fNgQr35u5ISn
         +YqNxpOJUA77dF/HeBu938gafRUvci20dXAZ6oNEQxNuSULIGYUB00fBkA2JPCY1H1Ft
         gIcGclV5n+RtMsvj7xc7Mp0QJr7YzT04zA01paZ7FVcH10xA7FzYtk7qEwtisvXX0ap8
         sDH5PPomcrzRxoGzaJ5Jz4dj0fUxNt23UmdaLnSN48C1KAHWxpiBZiJjnH5SPPnc86eH
         8k2JYtnL7ZvuGyyloLRX7uG/x+b4uuEZFkopCfIVjjObK6OBVRXB9iMPRa9jC3mS2gi0
         VaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=yjddGSgjNoB5y1kSapRuBtROwu0My00oEQswcqrZTOk=;
        b=OmrI+ExNI1RfStXQ1rWiqw/S8i7+ybXb7h7A9b68YYVND35ewpGu0uSNh8qYYK9IiH
         oT3OazGvBA9WyKQVlKHiwYWwbVa1OihBhXHZifVCLb9E2stpqH7uzvXEwHhSlaQWMXxT
         F/oU1jLEI5laNu/+PDonBId0SIrN8wzuWAqI8WdJ3/m6OfDfdz8ZOUsq2nEFmoEVmBt8
         BpA1ofkefeKD4Q79YGNYXoYVHhz6KTkP8wSngYPL8eTEF8qbHPrPwMYymW4Bpoza3r57
         Dio9xGsd1l3DDYDDLpyAXdWiRMeoJwQfF8GyPeZ3tm4Mr+P71GfLjIlPgWHbmEoPBSFg
         N+wA==
X-Gm-Message-State: AOAM532up4ywqnHPT10+Kz2FhQHConEcPwHMVSy4LO691tx0lTQe2PKc
        LfZoD3j48dflz4/Xq0jVS8e81A==
X-Google-Smtp-Source: ABdhPJzUczibBKb6cNI8OnKjHbmCtV9sPgW3t5k83bgUxci4EBbFgYvsP2Tt0GvMRV21Q6Nv2/k38g==
X-Received: by 2002:a17:90b:1183:: with SMTP id gk3mr17730833pjb.172.1619401703977;
        Sun, 25 Apr 2021 18:48:23 -0700 (PDT)
Received: from [2620:15c:17:3:f93a:1c09:9070:93a7] ([2620:15c:17:3:f93a:1c09:9070:93a7])
        by smtp.gmail.com with ESMTPSA id j24sm4531456pjy.1.2021.04.25.18.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 18:48:23 -0700 (PDT)
Date:   Sun, 25 Apr 2021 18:48:22 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     "Chu,Kaiping" <chukaiping@baidu.com>
cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "nigupta@nvidia.com" <nigupta@nvidia.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "mateusznosek0@gmail.com" <mateusznosek0@gmail.com>,
        "sh_def@163.com" <sh_def@163.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH_v3=5D_mm=2Fcompact?=
 =?UTF-8?Q?ion=3Alet_proactive_compaction_order_configurable?=
In-Reply-To: <14f6897b3dfd4314b85c5865a2f2b5d0@baidu.com>
Message-ID: <8ba0751b-8310-dcb8-5f74-97b9cb65a199@google.com>
References: <1619313662-30356-1-git-send-email-chukaiping@baidu.com> <f941268c-b91-594b-5de3-05fc418fbd0@google.com> <14f6897b3dfd4314b85c5865a2f2b5d0@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1482994552-1277834948-1619401703=:2029386"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-1277834948-1619401703=:2029386
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8BIT

On Mon, 26 Apr 2021, Chu,Kaiping wrote:

> Hi Rientjes
> I already answered your question in 4.19.
> " We turn off the transparent huge page in our machines, so we don't care about the order 9.
> There are many user space applications, different application maybe allocate different order of memory, we can't know the "known order of interest" in advance. Our purpose is to keep the overall fragment index as low as possible, not care about the specific order. 

Ok, so you don't care about a specific order but you are adding a 
vm.compaction_order sysctl?

I think what you're trying to do is invoke full compaction (cc.order = -1) 
at some point in time that will (1) keep node-wide fragmentation low over 
the long run and (2) be relatively lightweight at the time it is done.

I can certainly understand (1) on your configuration that is mostly 
consumed by 1GB gigantic pages, you are likely dealing with significant 
memory pressure that causes fragmentation to increase over time and 
eventually become unrecoverable for the most part.

And for (2), yes, using vm.compact_memory will become very heavyweight if 
it's done too late.

So since proactive compaction uses cc.order = 1, same as 
vm.compact_memory, it should be possible to monitor extfrag_index under 
debugfs and manually trigger compaction when necessary without 
intervention of the kernel.

I think we can both agree that we wouldn't want to add obscure and 
undocumented sysctls that that can easily be replaced by a userspace 
implementation.

> Although current proactive compaction mechanism only check the fragment index of specific order, but it can do memory compaction for all order(.order = -1 in proactive_compact_node), so it's still useful for us. 
> We set the compaction_order according to the average fragment index of all our machines, it's an experience value, it's a compromise of keep memory fragment index low and not trigger background compaction too much, this value can be changed in future.
> We did periodically memory compaction by command "echo 1 > /proc/sys/vm/compact_memory " previously, but it's not good enough, it's will compact all memory forcibly, it may lead to lots of memory move in short time, and affect the performance of application."
> 
> 
> BR,
> Chu Kaiping
> 
> -----邮件原件-----
> 发件人: David Rientjes <rientjes@google.com> 
> 发送时间: 2021年4月26日 9:15
> 收件人: Chu,Kaiping <chukaiping@baidu.com>
> 抄送: mcgrof@kernel.org; keescook@chromium.org; yzaikin@google.com; akpm@linux-foundation.org; vbabka@suse.cz; nigupta@nvidia.com; bhe@redhat.com; khalid.aziz@oracle.com; iamjoonsoo.kim@lge.com; mateusznosek0@gmail.com; sh_def@163.com; linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; linux-mm@kvack.org
> 主题: Re: [PATCH v3] mm/compaction:let proactive compaction order configurable
> 
> On Sun, 25 Apr 2021, chukaiping wrote:
> 
> > Currently the proactive compaction order is fixed to 
> > COMPACTION_HPAGE_ORDER(9), it's OK in most machines with lots of 
> > normal 4KB memory, but it's too high for the machines with small 
> > normal memory, for example the machines with most memory configured as 
> > 1GB hugetlbfs huge pages. In these machines the max order of free 
> > pages is often below 9, and it's always below 9 even with hard 
> > compaction. This will lead to proactive compaction be triggered very 
> > frequently. In these machines we only care about order of 3 or 4.
> > This patch export the oder to proc and let it configurable by user, 
> > and the default value is still COMPACTION_HPAGE_ORDER.
> > 
> 
> As asked in the review of the v1 of the patch, why is this not a userspace policy decision?  If you are interested in order-3 or order-4 fragmentation, for whatever reason, you could periodically check /proc/buddyinfo and manually invoke compaction on the system.
> 
> In other words, why does this need to live in the kernel?
> 
> > Signed-off-by: chukaiping <chukaiping@baidu.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> > 
> > Changes in v3:
> >     - change the min value of compaction_order to 1 because the fragmentation
> >       index of order 0 is always 0
> >     - move the definition of max_buddy_zone into #ifdef 
> > CONFIG_COMPACTION
> > 
> > Changes in v2:
> >     - fix the compile error in ia64 and powerpc, move the initialization
> >       of sysctl_compaction_order to kcompactd_init because 
> >       COMPACTION_HPAGE_ORDER is a variable in these architectures
> >     - change the hard coded max order number from 10 to MAX_ORDER - 1
> > 
> >  include/linux/compaction.h |    1 +
> >  kernel/sysctl.c            |   10 ++++++++++
> >  mm/compaction.c            |    9 ++++++---
> >  3 files changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/compaction.h b/include/linux/compaction.h 
> > index ed4070e..151ccd1 100644
> > --- a/include/linux/compaction.h
> > +++ b/include/linux/compaction.h
> > @@ -83,6 +83,7 @@ static inline unsigned long compact_gap(unsigned int 
> > order)  #ifdef CONFIG_COMPACTION  extern int sysctl_compact_memory;  
> > extern unsigned int sysctl_compaction_proactiveness;
> > +extern unsigned int sysctl_compaction_order;
> >  extern int sysctl_compaction_handler(struct ctl_table *table, int write,
> >  			void *buffer, size_t *length, loff_t *ppos);  extern int 
> > sysctl_extfrag_threshold; diff --git a/kernel/sysctl.c 
> > b/kernel/sysctl.c index 62fbd09..e50f7d2 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -196,6 +196,7 @@ enum sysctl_writes_mode {  #endif /* 
> > CONFIG_SCHED_DEBUG */
> >  
> >  #ifdef CONFIG_COMPACTION
> > +static int max_buddy_zone = MAX_ORDER - 1;
> >  static int min_extfrag_threshold;
> >  static int max_extfrag_threshold = 1000;  #endif @@ -2871,6 +2872,15 
> > @@ int proc_do_static_key(struct ctl_table *table, int write,
> >  		.extra2		= &one_hundred,
> >  	},
> >  	{
> > +		.procname       = "compaction_order",
> > +		.data           = &sysctl_compaction_order,
> > +		.maxlen         = sizeof(sysctl_compaction_order),
> > +		.mode           = 0644,
> > +		.proc_handler   = proc_dointvec_minmax,
> > +		.extra1         = SYSCTL_ONE,
> > +		.extra2         = &max_buddy_zone,
> > +	},
> > +	{
> >  		.procname	= "extfrag_threshold",
> >  		.data		= &sysctl_extfrag_threshold,
> >  		.maxlen		= sizeof(int),
> > diff --git a/mm/compaction.c b/mm/compaction.c index e04f447..70c0acd 
> > 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -1925,16 +1925,16 @@ static bool kswapd_is_running(pg_data_t 
> > *pgdat)
> >  
> >  /*
> >   * A zone's fragmentation score is the external fragmentation wrt to 
> > the
> > - * COMPACTION_HPAGE_ORDER. It returns a value in the range [0, 100].
> > + * sysctl_compaction_order. It returns a value in the range [0, 100].
> >   */
> >  static unsigned int fragmentation_score_zone(struct zone *zone)  {
> > -	return extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
> > +	return extfrag_for_order(zone, sysctl_compaction_order);
> >  }
> >  
> >  /*
> >   * A weighted zone's fragmentation score is the external 
> > fragmentation
> > - * wrt to the COMPACTION_HPAGE_ORDER scaled by the zone's size. It
> > + * wrt to the sysctl_compaction_order scaled by the zone's size. It
> >   * returns a value in the range [0, 100].
> >   *
> >   * The scaling factor ensures that proactive compaction focuses on 
> > larger @@ -2666,6 +2666,7 @@ static void compact_nodes(void)
> >   * background. It takes values in the range [0, 100].
> >   */
> >  unsigned int __read_mostly sysctl_compaction_proactiveness = 20;
> > +unsigned int __read_mostly sysctl_compaction_order;
> >  
> >  /*
> >   * This is the entry point for compacting all nodes via @@ -2958,6 
> > +2959,8 @@ static int __init kcompactd_init(void)
> >  	int nid;
> >  	int ret;
> >  
> > +	sysctl_compaction_order = COMPACTION_HPAGE_ORDER;
> > +
> >  	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> >  					"mm/compaction:online",
> >  					kcompactd_cpu_online, NULL);
> > --
> > 1.7.1
> > 
> > 
> 
--1482994552-1277834948-1619401703=:2029386--
