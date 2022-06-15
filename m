Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ADC54CEFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiFOQrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245195AbiFOQrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:47:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C97A12080;
        Wed, 15 Jun 2022 09:47:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i64so11945637pfc.8;
        Wed, 15 Jun 2022 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9LNaObpm8Up+d88THK7j7rjplRd3qN/NAg8yWi2diNY=;
        b=SEzTgTqa1tibXsbn9UFQMy9G1j3oY2LzsGeP1/MsJ5JJXf0sd7nyHGFUJ6/LOFFYdY
         H4EyGJK07bylBZJ7bWTbCDXGivk/AHDglGYTakidrgvK7ug3j2zUIb4bIjMmAUVf7T7X
         A7r2GSjnNOIRo9mArxNglUNnA141QT33PijaYjcvmcidjrfJppErZnv1ZExyZ+zbgvE8
         t+qt4QFLbrXBcns+UIsJXSJPv6aEX6xvL2dnHhguwHn28wfAF2b9jFg+tHQDnSb+Ps3n
         ftojStBruMb0ksJ36aCYFYwIfEoPTvtvpcrm0hxN8ngBIL51TfQKLIYq727o9PXGuNi+
         PPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9LNaObpm8Up+d88THK7j7rjplRd3qN/NAg8yWi2diNY=;
        b=vcIi4+W29e9ymxXoV4LjDdpP1bDVO/45i1f9CG6npbLfYKxPcA1oMKj4csdDVpo3tc
         JYJCJO8/ELPUPL5JDvrgvnRSAMTfK8beNAF7AP5pUK7Az5mqUeEAZRshBij1H6jEn3pR
         Tq9GtosPO5nDEikxKAxtHFYc235Eg5FvwRavIb9ybT8+rY2OsiFF2HMDvOTEj9A2+/td
         09vfCVXMAvIreuQsmxX295e1XD+WNfVJmvKCxSvfy7q/EKik0yi+7WNDWNEUZEphoMQN
         TMMDIH62fd7wXuxQ9NzlzvIhjQ1j9L49lZhfLW5PRGrPzFQKGYMG1MRfXwhXNvyNYWtq
         SJFw==
X-Gm-Message-State: AJIora/j7yPwLZSkONMPxe0tbHa/JD+WYNt5XC7lzcMc6+L/xEEdOTP9
        QXlPtVhiKwJ9KzxJPH88BOE=
X-Google-Smtp-Source: AGRyM1u3viDRQjQA5a9+XRpLEHSUbaKAGBHEbFtATV5l0RU0mettXUmjuzH+0a0EmpJMHBNq6wak1g==
X-Received: by 2002:a05:6a00:1690:b0:517:cc9e:3e2d with SMTP id k16-20020a056a00169000b00517cc9e3e2dmr527231pfc.0.1655311653545;
        Wed, 15 Jun 2022 09:47:33 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:aa45:48f4:5c45:8d55])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090a384100b001e307d66123sm2024477pjf.25.2022.06.15.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:47:32 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 15 Jun 2022 09:47:30 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     umgwanakikbuti@gmail.com, bigeasy@linutronix.de,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
Message-ID: <YqoNIgqYl8lWRFTZ@google.com>
References: <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
 <Yp/kpPA7GdbArXDo@google.com>
 <YqAL+HeZDk5Wug28@google.com>
 <YqAMmTiwcyS3Ttla@google.com>
 <YqANP1K/6oRNCUKZ@google.com>
 <YqBRZcsfrRMZXMCC@google.com>
 <CA+G9fYvjpCOcTVdpnHTOWaf3KcDeTM3Njn_NnXvU37ppoHH5uw@mail.gmail.com>
 <YqbtH9F47dkZghJ7@google.com>
 <Yqdqfz4Ycbg33k1R@google.com>
 <Yqf+PC+cKePAsaNI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqf+PC+cKePAsaNI@google.com>
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

On Tue, Jun 14, 2022 at 12:19:24PM +0900, Sergey Senozhatsky wrote:
> On (22/06/13 09:49), Minchan Kim wrote:
> > > Many thanks for the tests.
> > > 
> > > Quite honestly I was hoping that the patch would not help :) Well, ok,
> > > we now know that it's mapping area lock and the lockdep part of its
> > > memory is zero-ed out. The question is - "why?" It really should not
> > > be zeroed out.
> > 
> > Ccing Mike and Sebastian who are author/expert of the culprit patch
> > 
> > Naresh found zsmalloc crashed on the testing [1] and confirmed
> > that Sergey's patch[2] fixed the problem.
> > However, I don't understand why we need reinit the local_lock
> > on cpu_up handler[3].
> > 
> > Could you guys shed some light?
> 
> My guess is that it's either something very specific to Naresh's arch/config
> or a bug somewhere, which memset() per-CPU memory. Not sure how to track it
> down. KASAN maybe?
> 
> We certainly don't expect that
> 
> 	static DEFINE_PER_CPU(struct mapping_area, zs_map_area) = {
> 	        .lock   = INIT_LOCAL_LOCK(lock),
> 	};
> 
> would produce un-initialized dep_map. So I guess we start off with a
> valid per-CPU lock, but then it somehow gets zeroed-out.

Yes, I don't think we need to reinitialize the local_lock.

Naresh, we believe the patch Sergey provided for the test
was just band aid to hide the problem.

Could you please try to bisect it?
