Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AFA412D49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 05:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhIUDTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 23:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350402AbhIUC2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 22:28:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A0C0F3447;
        Mon, 20 Sep 2021 12:22:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso185553pjh.5;
        Mon, 20 Sep 2021 12:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JRnq/4c87bKbiNxvafGN4wtXqF6Tb113NW1CCy3N52o=;
        b=dP4iFexr0a+J311K54uCPdaewF9LzVRZkY/aDH2dPD9xGtZMHeZBij8v6wTihEifkg
         bIk6GbffogctONMlgfddQ0fGCNpmpMWipeajx9Kyn00jXWS5Lh89zABYQjixzMBZ+eaL
         Z57MjvIXj5H4kS2oNAwGRXtw/nv8xi3stLkDBC0ZBQ8vdA44wM0qv9TgId7KYVrQFIIj
         r9NHcIiUB87XojT59VuOwo9LjdF4v5XE5loPh5rx3Uuhui2pBXa+MAb9l6U3Wrz/18ZN
         8IPl4GNh1/xWGwqjOGo2nh7ySRJNyY6KBJST84Cnz0eSywHu1cHrx+2hzcPKYFzGH1NN
         eH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JRnq/4c87bKbiNxvafGN4wtXqF6Tb113NW1CCy3N52o=;
        b=3khiVuJWR+X38WAjkjDZnEngn962KSBLcBfmTMMWQ8sCZYLRvEw+4wdLQEGHLsiUZ0
         UiUC2twcSzfUk5fCviZ22BEZk+drnYitOgKnJKpKdO3RxgEE1Qw0zoeI2iIRTKscbsN3
         ul1di0HiE16Dd4mMfRCH8Isrzul91CkBFeU1viY9DIlVX9GpWSuN+CVKhjSF5IL7FRTw
         gUpmK2UvsgM5oeGWfYGQcytlW9PjocRezBZcyvCo4EJPERdkMnX+NSMZboQpuudo7fXZ
         /cVYuQuwQQg3H/on74ivxj3Iu+kfdL/GqNbcc8t0CMQRJRFGMNIMq5JwEsyD1+pG3BiO
         tpQg==
X-Gm-Message-State: AOAM530Cn/ufB9mOgQ3jDPr0Csg7BD3yMyO/Kb/mc/bcry0GnZC2Pfvn
        lzXIgcdIJbLKVCGqCJM2aRM=
X-Google-Smtp-Source: ABdhPJx7yMc6cu+sDCU/f0AwOhQkBHekSPHI+esLDq4+Bgpc7/NHJVGEMkfUVFWiJyicLFaEpDz9wg==
X-Received: by 2002:a17:902:6b8a:b029:12d:3f99:9e5e with SMTP id p10-20020a1709026b8ab029012d3f999e5emr24030103plk.66.1632165758222;
        Mon, 20 Sep 2021 12:22:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9d4d])
        by smtp.gmail.com with ESMTPSA id c23sm16287436pgb.74.2021.09.20.12.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:22:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 20 Sep 2021 09:22:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@aculab.com,
        bvanassche@acm.org, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, daniel.vetter@ffwll.ch, bhelgaas@google.com,
        kw@linux.com, dan.j.williams@intel.com, senozhatsky@chromium.org,
        hch@lst.de, joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YUjfeGuSVVq84iHc@mtj.duckdns.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
 <20210918050430.3671227-10-mcgrof@kernel.org>
 <YUjKjLzqpcxjRyit@slm.duckdns.org>
 <YUjdytEDkCughtSz@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUjdytEDkCughtSz@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, Sep 20, 2021 at 12:15:22PM -0700, Luis Chamberlain wrote:
> > I find this explanation odd because there's no real equivalent to locking
> > the module (as opposed to try locking) 
> 
> Actually there is, __module_get() but I suspect some of these users are
> probably incorrect and should be be moved to try. The documentation

__module_get() is just getting an extra ref when the caller already
has one (or more). It can't be used to freshly acquire a new
reference. There is no equivalence between the relationship between
try_module_get() and __module_get() and the one between spin_trylock()
and spin_lock().

> Right, the reason I mention the alternative is that we technically don't
> need to use try in this case since during a kernfs op it is implied the
> module will be pinned, but we have further motivations to use a try

I'm confused. If the module is already pinned, why are we getting an
extra reference? Also, I don't understand how this has that much to do
with preventing ddoses. I mean, it does cut down the duration of one
operation but the eventual gating is through whoever acquiring the
initial reference through try_module_get(), which again is the *only*
way to acquire a fresh reference.

Thanks.

-- 
tejun
