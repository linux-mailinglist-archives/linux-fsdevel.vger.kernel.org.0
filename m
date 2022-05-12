Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EC85252D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 18:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356604AbiELQl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 12:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiELQly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 12:41:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249AC5D5F6;
        Thu, 12 May 2022 09:41:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d22so5421030plr.9;
        Thu, 12 May 2022 09:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6TwX+Uem+RX7yFMEQloRfhp790CWUfMnBz6v8ZFXqWw=;
        b=W0iepvlelCLBuiCrQ0b37NsVuwjZqmnDvDuXQwTxPwqmfcisydLXhlvB+5bIBxb9Mo
         DDIm9SAd9GCqOj8Y1mqJ3sPE2DDD2VG+CyW+x8zKZGJ1ncvmUcgmSj5NWAatP+ff85TH
         ZnWqN4wW+Xvd09HvOI7ErGXsWF0qITMEkVBE8CptKkPKH0y41qpN2h8EhYFt/EnyW95X
         LUnS06SYFHbr1Fd4ZdIEgY2aNXkWlf7fBX3yTTPM4sIzGKDRzP8t5PBqeY5+wGCWKGeI
         4l9xLi0L1UoF0RefF/g+HEKdfK0lgVXEOyZZ3Lz8Yy/OIJTAikD/cX/wCLx1Gu2ea24/
         QN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6TwX+Uem+RX7yFMEQloRfhp790CWUfMnBz6v8ZFXqWw=;
        b=4Qx/+dLMe/UYMi/4NF5aXGTzt6txId//pn0zTeIZEmB7igS/a8vc1e7ruASYup9ViL
         vsmmNel4A2ato1HKfpQ9nHOlL1yjEAfpnOVbWzvvUtB/Xl0WAA6SvbiepWoeWFQSdoQV
         CX6n0ERvWDrz/IhAHDgbIJlxuWDysXisyjP3ok6RdzMcASdLNz89eix9umQIgeT9iScI
         yV6hkMzP+qxBErEl8vBV4sE5LdXk1BOYQvtpDR4c/pVLHGJwYdmYjq8Js/6lo6dKkilF
         jfUp1rnbu/tgBvtuyq36DlZQpZaJbdRA2eqtDTpcIbNpzi2NCzE4+Jk+pDK4Ay7duYRv
         ResQ==
X-Gm-Message-State: AOAM530g93I3/N321NxGBxcb0167fLbNgCKlQqX1I3cc/Ly3mZysNPCW
        5fMuj4oJAlo5bTTqViSMhB8=
X-Google-Smtp-Source: ABdhPJzsb54QRB11Kg0xwOQPwsZz32Td9eLOjqUbH9eOlCaQUD4CO9IvOZZ+4QXL8vYjVErb6WonGA==
X-Received: by 2002:a17:902:ab96:b0:159:1ff:4ea0 with SMTP id f22-20020a170902ab9600b0015901ff4ea0mr779294plr.60.1652373713356;
        Thu, 12 May 2022 09:41:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:6c64])
        by smtp.gmail.com with ESMTPSA id x4-20020a62fb04000000b0050dc76281a9sm46574pfm.131.2022.05.12.09.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:41:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 May 2022 06:41:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tytso@mit.edu, willy@infradead.org,
        david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, mcgrof@kernel.org, holt@sgi.com
Subject: Re: [REPORT] syscall reboot + umh + firmware fallback
Message-ID: <Yn04z6xzqJQqYNOX@slm.duckdns.org>
References: <YnzQHWASAxsGL9HW@slm.duckdns.org>
 <1652354304-17492-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652354304-17492-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Thu, May 12, 2022 at 08:18:24PM +0900, Byungchul Park wrote:
> > 1. wait_for_completion_killable_timeout() doesn't need someone to wake it up
> >    to make forward progress because it will unstick itself after timeout
> >    expires.
> 
> I have a question about this one. Yes, it would never been stuck thanks
> to timeout. However, IIUC, timeouts are not supposed to expire in normal
> cases. So I thought a timeout expiration means not a normal case so need
> to inform it in terms of dependency so as to prevent further expiraton.
> That's why I have been trying to track even timeout'ed APIs.
> 
> Do you think DEPT shouldn't track timeout APIs? If I was wrong, I
> shouldn't track the timeout APIs any more.

Without actually surveying the use cases, I can't say for sure but my
experience has been that we often get pretty creative with timeouts and it's
something people actively think about and monitor (and it's usually not
subtle). Given that, I'm skeptical about how much value it'd add for a
dependency checker to warn about timeouts. It might be net negative than the
other way around.

> > 2. complete_all() from __fw_load_abort() isn't the only source of wakeup.
> >    The fw loader can be, and mainly should be, woken up by firmware loading
> >    actually completing instead of being aborted.
> 
> This is the point I'd like to ask. In normal cases, fw_load_done() might
> happen, of course, if the loading gets completed. However, I was
> wondering if the kernel ensures either fw_load_done() or fw_load_abort()
> to be called by *another* context while kernel_halt().

We'll have to walk through the code to tell that. On a cursory look tho, up
until that point (just before shutting down usermode helper), I don't see
anything which would actively block firmware loading.

Thanks.

-- 
tejun
