Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A9B4CD3A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 12:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiCDLkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 06:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiCDLk3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:40:29 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2A145E12;
        Fri,  4 Mar 2022 03:39:42 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso10390429pjj.2;
        Fri, 04 Mar 2022 03:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T0KWcfrVhfRiQuPhzFUu+oUHR0+0iQuCKbqqyufUMXA=;
        b=BS4C5Y1tL4r8PWIRqTmC6gS0HaL1ikR+470ZGcTaIa4wFQYparRJpFgi8byBxYfS+3
         h+/0V9Om3+A1FxjtUhzi8xUX8SQHq+v8HkFoG+J6SemhINeDJSnxowDMKlAz8H8duGxN
         dQUqq+1LAnYBfNHP7SN7AA2Kj/WI0bj5UMk5D1tTDQS+yqA1Cfs9LXdRBoRhuywGMkHh
         uxofCQJrdhXypoU+Kck6or68lCBk3WDfd06ViBAREudViDBHavC9dOljVk6YKVx+g6tI
         ywHzdC7NPv1PVpGFaSAGB5AQ+PPtoXYZIHynTx/iBcL2C16vxnOubx0fFVbm7AZnrUe7
         ko/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T0KWcfrVhfRiQuPhzFUu+oUHR0+0iQuCKbqqyufUMXA=;
        b=SUm9pOojNamHPikMlB/n+EFKQFn3Rg0DDWlrp1hfpRaXk/NQJfqcUDmbqOM68K6PLg
         REBrtim79cDhhEAvhxvgisnVKhxdhi5kd02XyaEn8XKxBPEK4miUimkxL9LGOc/KxF36
         n7Hhld7eU2PY/2XhEZHd/z0sYBiz275zgtvo+8oB3gL9oUvRNa/2WHwtz3chcWisFZZr
         Shj2psy3XglQEgff2yELmuVfH/oU7e/nw4XQDa8jI2RPSf92kNizoaEegxxttEIEX7oM
         LY/J7qWjSF58EkFxVKzXZ0rrwRXr/LHmQvgcLSdwDiDMgd4FKa9nXQjqh7lPFzvFY2i2
         w6tA==
X-Gm-Message-State: AOAM533fUHX1ynobtTFmoTJgqDlhesmnWPAFZTwUKLyiIKr9Xk5n8mYL
        /hBBGJytElepF23W2/dANNA=
X-Google-Smtp-Source: ABdhPJwUeGy/HJBpt8MjGZ13EzUfgfohEC7mxxbk5v1dgWi77zTAJpDwQo+/X8i3EoW7ntQ/oQ2ZNw==
X-Received: by 2002:a17:90b:390c:b0:1bf:2d83:c70c with SMTP id ob12-20020a17090b390c00b001bf2d83c70cmr1346393pjb.217.1646393982299;
        Fri, 04 Mar 2022 03:39:42 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id e18-20020a63d952000000b00372a1295210sm4394691pgj.51.2022.03.04.03.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 03:39:41 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:39:29 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jack@suse.com,
        jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        djwong@kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com
Subject: Re: [PATCH v4 22/24] dept: Don't create dependencies between
 different depths in any case
Message-ID: <YiH6cXo1qThA1X6B@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <1646377603-19730-1-git-send-email-byungchul.park@lge.com>
 <1646377603-19730-23-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646377603-19730-23-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 04, 2022 at 04:06:41PM +0900, Byungchul Park wrote:
> Dept already prevents creating dependencies between different depths of
> the class indicated by *_lock_nested() when the lock acquisitions happen
> consecutively.
> 
>    lock A0 with depth
>    lock_nested A1 with depth + 1
>    ...
>    unlock A1
>    unlock A0
> 
> Dept does not create A0 -> A1 dependency in this case, either.
> 
> However, once another class cut in, the code becomes problematic. When
> Dept tries to create real dependencies, it does not only create real
> ones but also wrong ones between different depths of the class.
> 
>    lock A0 with depth
>    lock B
>    lock_nested A1 with depth + 1
>    ...
>    unlock A1
>    unlock B
>    unlock A0
> 
> Even in this case, Dept should not create A0 -> A1 dependency.
> 
> So let Dept not create wrong dependencies between different depths of
> the class in any case.
> 
> Reported-by: 42.hyeyoo@gmail.com
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> ---
>  kernel/dependency/dept.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index 5d4efc3..cc1b3a3 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c
> @@ -1458,14 +1458,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
>  
>  		eh = dt->ecxt_held + i;
>  		if (eh->ecxt->class != c || eh->nest == ne)
> -			break;
> -	}
> -
> -	for (; i >= 0; i--) {
> -		struct dept_ecxt_held *eh;
> -
> -		eh = dt->ecxt_held + i;
> -		add_dep(eh->ecxt, w);
> +			add_dep(eh->ecxt, w);
>  	}
>  
>  	if (!wait_consumed(w) && !rich_stack) {
> -- 
> 1.9.1
> 
> 

Works as expected, Thanks!
I would report if there is anything else interesting.

Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thank you, You are awesome!
Hyeonggon :-)
