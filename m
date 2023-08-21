Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7453B7822F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjHUEkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjHUEky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:40:54 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93114A8;
        Sun, 20 Aug 2023 21:40:48 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-09-64e2eacf1ef5
Date:   Mon, 21 Aug 2023 13:37:44 +0900
From:   Byungchul Park <byungchul@sk.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
        torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: Re: [RESEND PATCH v10 08/25] dept: Apply
 sdt_might_sleep_{start,end}() to PG_{locked,writeback} wait
Message-ID: <20230821043744.GA73328@system.software.com>
References: <20230821034637.34630-1-byungchul@sk.com>
 <20230821034637.34630-9-byungchul@sk.com>
 <ZOLjiF2oKxBvVzyw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOLjiF2oKxBvVzyw@casper.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH8zz3lWrnpZP4SBenXcgWFpwyDCebMUu2yE0WExM1cfoBm/Vm
        NFIgrYD4FphFWxAGmtJZiULB2mDV7YKuY+AYRKCSSafMdYhEauNAeUmY7caKZXTEzC8nv5yX
        X/4fDk+pFphkXp93QDLmaXM1rIJWTC13pg0+Deo2XPe+D7WnNkD4uYWG+mseFvxXLyPwtJVh
        mLiVBb9FJhFEfx6kwG7zI2gce0hBW+8ogk73lyzcC70GQ+EZFny2ShaON11j4Zdn8xhG6k5j
        uCxvg4EaJ4auuT9osE+wcM5+HC+WcQxzrhYOXKUpEHQ7OJgf2wi+0fsMdA6/C2fPj7DQ0emj
        odcbxHCvvZ6FUc8CAwO9/TT4a6sYuDLtZOFZxEWBKzzDwd2uBgzfmBdFJ/6MMdBX1YXhRPO3
        GIZ+/wHBTcsjDLLnPgs94UkMrbKNgn8u3UIQrJ7ioPzUHAfnyqoRVJbX0TD4oo8B88gmiP5d
        z370gdgzOUOJ5tZisTPSQIu3nUT83vGQE803hzmxQS4UW92pYlPHBBYbZ8OMKLdYWVGePc2J
        FVNDWJy+c4cT+7+O0mJoyI63q/coNuukXH2RZHxvyz5FzsIZF1NgW3bQed2PS9E4X4ESeCJk
        kMrwc/olB0K1KM60kEKuTv/4H7PC2yQQmKMqEM+vFN4hk23p8TYl9CvIV/WH4vy6kE8CNXVU
        nJUCEIttnK1ACl4lVCJir75BLw0Sie9siF46TiWB2ASOOylBTS7F+DgmLEZ4IhfHN5KEt0jX
        jT4c1xChJ4E0mcu4pZiryU/uAF2DBMcrVscrVsf/1gZEtSCVPq/IoNXnZqzPKcnTH1z/eb5B
        Rotv6To6v9eLZv07upHAI81y5b43gjoVoy0ylRi6EeEpzUql+q8xnUqp05Yckoz52cbCXMnU
        jdQ8rVmlTI8U61TCF9oD0n5JKpCML6eYT0guRUmqgoHD9geJR5PhceRu7aO6C+FW7yp5RVm3
        J5M9aazaneXZuoJe3Uzah73R8pD5Y3U0p3nti2NPvmvM2Gk1RT/b2dG+69O9+z/MzvzVkJh2
        clZT8klqtu7YRV12e6HVYjlyxprmc1ulp6pYeWwQ39785o6ZlPTMNVnrmpJco1sMGtqUo92Y
        ShlN2n8BhnS87JIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH9zzvlY7qS4f6BlxiuhiVecPM5MTLLlmmT1w0274s3iKNfZXG
        AqZVEBINSm2Qm6CUQkWD1RUCKFrQ4LTagFw6olQh2hlA2zRCtYIyC3YgjM4s88vJL+d/fifn
        w+EphZeJ4zWpByRdqkqrZGW0bMvanGXdL3zqlb/5Y6CkYCWE3ubSUNlQz4L7ch2C+qajGAJt
        G+HxWBDBxL1uCswmN4Lz3n4KmtoHEDhqjrHQ458FvaERFlymfBZyLjSw8ODlJIa+slMY6uyb
        oavYisEZHqTBHGDhjDkHz5QhDGFbLQe27IXgq7FwMOlNBNfAIwZaz7oYcDz5EirO9bFwy+Gi
        ob3Zh6Hn90oWBuqnGehq76TBXVLIwKVhKwsvx2wU2EIjHDx0VmG4YpjZZvxrioGOQicG48Wr
        GHr/vIngdu4zDPb6Ryy0hoIYGu0mCv6ubkPgK3rFwfGCMAdnjhYhyD9eRkP3+w4GDH2rYeJd
        JfvtWtIaHKGIoTGDOMaqaPKHVSQ3LP0cMdx+wpEq+0HSWJNALtwKYHJ+NMQQe+0JlthHT3Ek
        71UvJsP373Oks3yCJv5eM/5p/jbZOrWk1aRLuhVfJ8mSp0/bmP2mTw9Zr7lxNhri81AULwpf
        iR5/CYowLSwULw/f+ZdZYZHo8YSpPMTzscJiMdi0KtKmhE6ZeLIyK8KfCWmip7iMirBcADHX
        NMTmIRmvEPKRaC66Tn8IYkRXhZ/+ICeInqkAjuykhHixeoqPYNTMCc/tGZGJOcIXovN6By5G
        cstHsuUj2fK/XIWoWhSrSU1PUWm0q5fr9yVnpmoOLd+dlmJHM49nOzxZ0oze9mxsQQKPlNHy
        pPk+tYJRpeszU1qQyFPKWHn8uFetkKtVmVmSLm2X7qBW0regeJ5WzpNv+lVKUgh7VQekfZK0
        X9L9l2I+Ki4bFW6PCWjftyZ6v/9l9pK42J8rjtyZNj60ij9QBaUvvpsoX7rmRuZOxY6x7NHB
        Je+efeL+PDh7gWf9+CqT87F7q/DNyd13l5ZmvfnxQWlGc8OGuW0xr/d4jTv5dZsdmxJed8Fe
        W13AHDaoPesHo/sHNuwoP5afcU89q7q6jzydvBg9fsKopPXJqsQESqdX/QMZ9r0hdAMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 21, 2023 at 05:09:44AM +0100, Matthew Wilcox wrote:
> On Mon, Aug 21, 2023 at 12:46:20PM +0900, Byungchul Park wrote:
> > @@ -1219,6 +1220,9 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
> >  /* How many times do we accept lock stealing from under a waiter? */
> >  int sysctl_page_lock_unfairness = 5;
> >  
> > +static struct dept_map __maybe_unused PG_locked_map = DEPT_MAP_INITIALIZER(PG_locked_map, NULL);
> > +static struct dept_map __maybe_unused PG_writeback_map = DEPT_MAP_INITIALIZER(PG_writeback_map, NULL);
> 
> Hmm, why are these "maybe unused"?  *digs*.  Ah.  Because
> sdt_might_sleep_start() becomes a no-op macro if DEPT is disabled.
> 
> OK, the right way to handle this is
> 
> #ifdef CONFIG_DEPT
> #define DEPT_MAP(name)	static struct dept_map name = \
> 		DEPT_MAP_INITIALIZER(name, NULL)
> #else
> #define DEPT_MAP(name)	/* */
> #endif
> 
> And now DEPT takes up no space if disabled.

Currently:

   #if !defined(CONFIG_DEPT)
   struct dept_map { }; 
   #endif

So I think it doesn't take space at all. Do you think I still need to
introduce e.g. DEPT_MAP()? Then I will. Thank you!

	Byungchul

> /* */; is a somewhat unusual thing to see, but since this must work at
> top level, we can't use "do { } while (0)" like we usually do.  Given
> where else this is likely to be used, i don't think it's going to be
> a problem ...
