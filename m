Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD7A4C9CC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 05:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiCBEyj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 23:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiCBEyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:54:37 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8887BB150C;
        Tue,  1 Mar 2022 20:53:54 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 27so640373pgk.10;
        Tue, 01 Mar 2022 20:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nNi4rMqg08CCrpEt9N8/H4Odr1aWwbhtB5E4unm3mVA=;
        b=aTK+2SIkmj0YCy3LfaTX7xI10dtEgXOhPOlOkEIAcRmYIhXTVrV+4obrF/HAC/E4RP
         thxxSltqgn80CKK/IsYyTe+37x3HMgPzvwNyTjQHXcxhGEMWPKIfIm8sq7Hcm5uDdlZW
         8mTvAXX2ZDpyOcW0Ipmbvf/oquLo6sUBSVok+Snsw/1O1aisT3Qr7ci4urU2Ghl4WhsM
         can3P6KDsKsQMUf3O4fIedCUVMxSpzs8kqfuwYSkgiyEXDcSaVbiXS8DKUbatpkLCnBL
         0lFlzYMn7OiLjidLwQZAT41PUKCbzY7aFFEFeS+95kobv6MlptrGnaw7GyKYQVJt2Ubb
         3OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNi4rMqg08CCrpEt9N8/H4Odr1aWwbhtB5E4unm3mVA=;
        b=BVe7jFKdDvXRUk+WfuPYidKbaeMq8H3t8LeB2RyZs1CLVxbJg1q/NIzjriOKXVJfGd
         ZoP9BdaYW6+icwSCkLB9oY23qdZwqpZq0Qm2ZYzikRKNp3/K0GAkrc+Kze9PLiolUELm
         pK66ZRDCclNYZ3lGiqLWseJVRBYO7GKkDSSPSXsjtF/uomd2LRaZkUAxtSzQlqSedqve
         heks4nljBgvcwmX/EBetbLeBoC+lhqZuqQFN48pfi2JvWYkaYdn/HPmlKw1piybn5dyD
         VwWoQwP3oUt1ufT2mHHo+UN4G/wCVWkOBqZBCQySXzuuQQXet4hW3Oci5zy37fbDkhrm
         4rMQ==
X-Gm-Message-State: AOAM532HOAbXJqW8jan0GNx8OMIbjxoZYnTe7g8x8pE5hbiYnkYB64BQ
        hw9UmVo+laMup5CXadBdDI8=
X-Google-Smtp-Source: ABdhPJxfU+Zk4/I1aHYGv00DHbooJyvOZzR43S+TPguw15+w148owaMwAlgFuPKmmKJnMgw9jCCjCg==
X-Received: by 2002:a05:6a00:130e:b0:4cc:3c7d:4dec with SMTP id j14-20020a056a00130e00b004cc3c7d4decmr31361435pfu.32.1646196833916;
        Tue, 01 Mar 2022 20:53:53 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id b1-20020a630c01000000b003758d1a40easm14175994pgl.19.2022.03.01.20.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 20:53:53 -0800 (PST)
Date:   Wed, 2 Mar 2022 04:53:41 +0000
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
Subject: Re: [PATCH v3 00/21] DEPT(Dependency Tracker)
Message-ID: <Yh74VbNZZt35wHZD@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <1646042220-28952-1-git-send-email-byungchul.park@lge.com>
 <Yh70VkRkUfwIjPWv@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh70VkRkUfwIjPWv@ip-172-31-19-208.ap-northeast-1.compute.internal>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:36:38AM +0000, Hyeonggon Yoo wrote:
> On Mon, Feb 28, 2022 at 06:56:39PM +0900, Byungchul Park wrote:
> > I didn't want to bother you so I was planning to send the next spin
> > after making more progress. However, PATCH v2 reports too many false
> > positives because Dept tracked the bit_wait_table[] wrong way - I
> > apologize for that. So I decided to send PATCH v3 first before going
> > further for those who want to run Dept for now.
> > 
> > There might still be some false positives but not overwhelming.
> >
> 
> Hello Byungchul, I'm running DEPT v3 on my system
> and I see report below.
> 
> Looking at the kmemleak code and comment, I think
> kmemleak tried to avoid lockdep recursive warning
> but detected by DEPT?
>

Forgot to include another warning caused by DEPT.

And comment below might be useful for debugging:

in kmemleak.c:
  43  * Locks and mutexes are acquired/nested in the following order:
  44  *
  45  *   scan_mutex [-> object->lock] -> kmemleak_lock -> other_object->lock (SINGLE_DEPTH_NESTING)
  46  *
  47  * No kmemleak_lock and object->lock nesting is allowed outside scan_mutex
  48  * regions.

===================================================
DEPT: Circular dependency has been detected.
5.17.0-rc1+ #1 Tainted: G        W        
---------------------------------------------------
summary
---------------------------------------------------
*** DEADLOCK ***

context A
    [S] __raw_spin_lock_irqsave(&object->lock:0)
    [W] __raw_spin_lock_irqsave(kmemleak_lock:0)
    [E] spin_unlock(&object->lock:0)

context B
    [S] __raw_spin_lock_irqsave(kmemleak_lock:0)
    [W] _raw_spin_lock_nested(&object->lock:0)
    [E] spin_unlock(kmemleak_lock:0)

[S]: start of the event context
[W]: the wait blocked
[E]: the event not reachable

---------------------------------------------------
context A's detail
---------------------------------------------------
context A
    [S] __raw_spin_lock_irqsave(&object->lock:0)
    [W] __raw_spin_lock_irqsave(kmemleak_lock:0)
    [E] spin_unlock(&object->lock:0)

[S] __raw_spin_lock_irqsave(&object->lock:0):
[<ffffffc00810302c>] scan_gray_list+0x84/0x13c
stacktrace:
      dept_ecxt_enter+0x88/0xf4
      _raw_spin_lock_irqsave+0xf0/0x1c4
      scan_gray_list+0x84/0x13c
      kmemleak_scan+0x2d8/0x54c
      kmemleak_scan_thread+0xac/0xd4
      kthread+0xd4/0xe4
      ret_from_fork+0x10/0x20

[W] __raw_spin_lock_irqsave(kmemleak_lock:0):
[<ffffffc008102ebc>] scan_block+0x3c/0x128
stacktrace:
      __dept_wait+0x8c/0xa4
      dept_wait+0x6c/0x88
      _raw_spin_lock_irqsave+0xb8/0x1c4
      scan_block+0x3c/0x128
      scan_gray_list+0xc4/0x13c
      kmemleak_scan+0x2d8/0x54c
      kmemleak_scan_thread+0xac/0xd4
      kthread+0xd4/0xe4
      ret_from_fork+0x10/0x20

[E] spin_unlock(&object->lock:0):
[<ffffffc008102ee0>] scan_block+0x60/0x128

---------------------------------------------------
context B's detail
---------------------------------------------------
context B
    [S] __raw_spin_lock_irqsave(kmemleak_lock:0)
    [W] _raw_spin_lock_nested(&object->lock:0)
    [E] spin_unlock(kmemleak_lock:0)

[S] __raw_spin_lock_irqsave(kmemleak_lock:0):
[<ffffffc008102ebc>] scan_block+0x3c/0x128
stacktrace:
      dept_ecxt_enter+0x88/0xf4
      _raw_spin_lock_irqsave+0xf0/0x1c4
      scan_block+0x3c/0x128
      kmemleak_scan+0x19c/0x54c
      kmemleak_scan_thread+0xac/0xd4
      kthread+0xd4/0xe4
      ret_from_fork+0x10/0x20

[W] _raw_spin_lock_nested(&object->lock:0):
[<ffffffc008102f34>] scan_block+0xb4/0x128
stacktrace:
      dept_wait+0x74/0x88
      _raw_spin_lock_nested+0xa8/0x1b0
      scan_block+0xb4/0x128
      kmemleak_scan+0x19c/0x54c
      kmemleak_scan_thread+0xac/0xd4
      kthread+0xd4/0xe4
      ret_from_fork+0x10/0x20
[E] spin_unlock(kmemleak_lock:0):
[<ffffffc008102ee0>] scan_block+0x60/0x128
stacktrace:
      dept_event+0x7c/0xfc
      _raw_spin_unlock_irqrestore+0x8c/0x120
      scan_block+0x60/0x128
      kmemleak_scan+0x19c/0x54c
      kmemleak_scan_thread+0xac/0xd4
      kthread+0xd4/0xe4
      ret_from_fork+0x10/0x20
---------------------------------------------------
information that might be helpful
---------------------------------------------------
CPU: 1 PID: 38 Comm: kmemleak Tainted: G        W         5.17.0-rc1+ #1
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace.part.0+0x9c/0xc4
 show_stack+0x14/0x28
 dump_stack_lvl+0x9c/0xcc
 dump_stack+0x14/0x2c
 print_circle+0x2d4/0x438
 cb_check_dl+0x6c/0x70
 bfs+0xc0/0x168
 add_dep+0x88/0x11c
 add_wait+0x2d0/0x2dc
 __dept_wait+0x8c/0xa4
 dept_wait+0x6c/0x88
 _raw_spin_lock_irqsave+0xb8/0x1c4
 scan_block+0x3c/0x128
 scan_gray_list+0xc4/0x13c
 kmemleak_scan+0x2d8/0x54c
 kmemleak_scan_thread+0xac/0xd4
 kthread+0xd4/0xe4
 ret_from_fork+0x10/0x20

> ===================================================
> DEPT: Circular dependency has been detected.
> 5.17.0-rc1+ #1 Tainted: G        W
> ---------------------------------------------------
> summary
> ---------------------------------------------------
> *** AA DEADLOCK ***
> 
> context A
>     [S] __raw_spin_lock_irqsave(&object->lock:0)
>     [W] _raw_spin_lock_nested(&object->lock:0)
>     [E] spin_unlock(&object->lock:0)
> 
> [S]: start of the event context
> [W]: the wait blocked
> [E]: the event not reachable
> ---------------------------------------------------
> context A's detail
> ---------------------------------------------------
> context A
>     [S] __raw_spin_lock_irqsave(&object->lock:0)
>     [W] _raw_spin_lock_nested(&object->lock:0)
>     [E] spin_unlock(&object->lock:0)
> 
> [S] __raw_spin_lock_irqsave(&object->lock:0):
> [<ffffffc00810302c>] scan_gray_list+0x84/0x13c
> stacktrace:
>       dept_ecxt_enter+0x88/0xf4
>       _raw_spin_lock_irqsave+0xf0/0x1c4
>       scan_gray_list+0x84/0x13c
>       kmemleak_scan+0x2d8/0x54c
>       kmemleak_scan_thread+0xac/0xd4
>       kthread+0xd4/0xe4
>       ret_from_fork+0x10/0x20
> 
> [E] spin_unlock(&object->lock:0):
> [<ffffffc008102ee0>] scan_block+0x60/0x128
> ---------------------------------------------------
> information that might be helpful
> ---------------------------------------------------
> CPU: 1 PID: 38 Comm: kmemleak Tainted: G        W         5.17.0-rc1+ #1
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  dump_backtrace.part.0+0x9c/0xc4
>  show_stack+0x14/0x28
>  dump_stack_lvl+0x9c/0xcc
>  dump_stack+0x14/0x2c
>  print_circle+0x2d4/0x438
>  cb_check_dl+0x44/0x70
>  bfs+0x60/0x168
>  add_dep+0x88/0x11c
>  add_wait+0x2d0/0x2dc
>  __dept_wait+0x8c/0xa4
>  dept_wait+0x6c/0x88
>  _raw_spin_lock_nested+0xa8/0x1b0
>  scan_block+0xb4/0x128
>  scan_gray_list+0xc4/0x13c
>  kmemleak_scan+0x2d8/0x54c
>  kmemleak_scan_thread+0xac/0xd4
>  kthread+0xd4/0xe4
>  ret_from_fork+0x10/0x20
>
[...]

--
Thank you, You are awesome!
Hyeonggon :-)
