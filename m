Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C5B52EE5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbiETOoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 10:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbiETOoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 10:44:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAB5170F22;
        Fri, 20 May 2022 07:44:09 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id o22so9905196ljp.8;
        Fri, 20 May 2022 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HvTH7kTqzy41nEqrUcV5MWl5ihmbkENsfHKsoEvLo8w=;
        b=QhKs/1rDerJGygqt7Wpy9kVmpyr6zt/MR2f0lfmo1d7OcpvKITr1BO17UoqnSqsu0B
         PI7mrht47FKS+7BqaTyR2JBrNK2rFBoq93nsBOozBhOxt6Te0zrdBYeCrRdddfpao9gx
         HBe7kDpTTA035uqZjJVa0jPJQdKqfNa0Y4R1XCbs4O2ZNZvk9nPPCvRPnrjAAyVqLaCw
         h9AClIwYI8aUv7jOvE5yOOheqItZt2u42mGhRFQ0b8+6fUB0Q29BK0MmL00cIIPph9xt
         lmY/5vRhCTJQAtzFQDjevfLGWvgXrxciq7aYUhK6xZMcX0euFct/D+aAHwP62wX8ecLX
         E+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HvTH7kTqzy41nEqrUcV5MWl5ihmbkENsfHKsoEvLo8w=;
        b=aob8w8+kqV3CkdDOWmHuyMS+y2PqQMzHT+yytHmuz0XgcGOGoBgljI5KbG/ny+seKI
         FVeW1KBR4g7YuB024x6lqd+nS8eYYMghaanYykiS71xbWOyv2rWXEbL9tuPSGbJjcxcs
         Z+N3f0XJPQEc5tJC5oBSG0PaytxbLioAlsUnwLh1msK3vb0PpOxHJJxZSgRIO3auhvrf
         +o3IJqJX/GBCo0ZuNLJX4/kxnYkjBJTh+H6juVCT1Eq6aHeflX+5sNf764YSyoQJ8SOU
         27EJekdt37jK1rpjVlpM02p4EzlHertEn6hQpwqlkm9ZKGVrqhptkk8p7sKr/yvEza4H
         a3IA==
X-Gm-Message-State: AOAM533KilGa1coFA1G2jucqSCTs8eVY03zXwL4fsgJe1XsGwufzCeOB
        mv7wonvl8GggefMf5bn8S5c=
X-Google-Smtp-Source: ABdhPJwxT9f+fJAt0Ud4uf2Hzwjk0VK8wD0UarqX+cQwVT/lNJNb4l+tOpn7FfdyAEmUsWvkzFPJmQ==
X-Received: by 2002:a2e:330f:0:b0:253:da40:de51 with SMTP id d15-20020a2e330f000000b00253da40de51mr3388862ljc.76.1653057847786;
        Fri, 20 May 2022 07:44:07 -0700 (PDT)
Received: from localhost (87-49-45-243-mobile.dk.customer.tdc.net. [87.49.45.243])
        by smtp.gmail.com with ESMTPSA id r26-20020a19441a000000b00477ce8cf243sm406681lfa.55.2022.05.20.07.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 07:44:07 -0700 (PDT)
Date:   Fri, 20 May 2022 16:44:05 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        patches@lists.linux.dev, amir73il@gmail.com, tytso@mit.edu,
        josef@toxicpanda.com, jmeneghi@redhat.com, jake@lwn.net
Subject: Re: [PATCH 3/4] playbooks: add a common playbook a git reset task
 for kdevops
Message-ID: <20220520144405.uzzejos24qizwa5c@quentin>
References: <20220513193831.4136212-1-mcgrof@kernel.org>
 <20220513193831.4136212-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513193831.4136212-4-mcgrof@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Luis,

On Fri, May 13, 2022 at 12:38:30PM -0700, Luis Chamberlain wrote:
> Two playbooks share the concept of git cloning kdevops into
> the target nodes (guests, cloud hosts, baremetal hosts) so that
> expunge files can be used for avoiding tests. If you decide
> you want to change the URL for that git tree it may not be
> so obvious what to do.
> 
> Fortunately the solution is simple. You just tell ansible to use
> the new git tree URL. That's it. It won't remove the old directory
> and things work as expected.
> 
> But since we use the kdevops git tree on both fstests and blktests
> it is not so obvious to developers that the thing to do here is
> to just run 'make fstests' or 'make blktests' and even that is not
> as efficient as that will also re-clone the fstests or blktests
> tree respectively. When we just want to reset the kdevops git tree
> we currently have no semantics to specify that. But since this is
> a common post-deployment goal, just add a common playbook that let's
> us do common tasks.
> 
> All we need then is the kconfig logic to define when some commmon
> tasks might make sense. So to reset your kdevops git tree, all you
> have to do now is change the configuration for it, then run:
> 
> make
> make kdevops-git-reset
> 

While I do like the idea of having this option, I still do not
understand the main use case to have it as a separate make target.
Wouldn't the developer already put the custom kdevops tree with
CONFIG_WORKFLOW_KDEVOPS_GIT during the initial make menuconfig phase?

I am just trying to understand the usecase when someone wants to change
the kdevops tree after a test run. Maybe I am missing something here.
-- 
Pankaj Raghav
