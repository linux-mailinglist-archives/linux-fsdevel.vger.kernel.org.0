Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC01F59ED8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 22:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiHWUlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiHWUlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:41:16 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF63A45061;
        Tue, 23 Aug 2022 13:31:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 202so13228908pgc.8;
        Tue, 23 Aug 2022 13:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=JMXz8A2xJ91prAWbdCfT0dCK746jNn15pml4FJddUZ8=;
        b=lmkye2UN1b4Q7U05sYHomO8ANCWbC2gTBnpPjVRELIc6kfHqRd/Vo/Ccvxpv/f4gLm
         +WwN6KKqBz8qjtaRwUT2A6TuvAy6OlihkwWkGZasqLipMS7io4ukK9q5rEJ2UxmvMdfE
         S6V8ukVXGO1bgoCMj5x/71nv9WjCe94IbSeslxVVvuayrxoUeRNDJAPWAmQ1YHCdVcLu
         OpLgC2x08A6PfttMb9GmavnM9gqqjYDaizZhUYznFUnHc0QQFysHPpFCg2orUP4SWR8w
         +fVbObx5l7fOvs04vUAzq+fEddctQCCLBMSFqtuVpcPR4D+kjNG0XXXlK5ZF7KUvCHmM
         yOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=JMXz8A2xJ91prAWbdCfT0dCK746jNn15pml4FJddUZ8=;
        b=HChtXyWM+5NLOqQfMcgAy+L4e+zBwIiRupYjHbzfWEle5A/OP25vruxgcEPIcUsz62
         M2psmHotqUmdk5/NDRlJWQpTilh95JHE5DPyHS0M20QLhQN/fsI1s1BBkZPzhMRNDA8z
         5qyyDRDsr12W1vRjRAa6w2+andqmp4wLyer8ZEFgsU0jOFBUiaVWI63schhmHR4GHZzQ
         FYQDPXbiE2IVXu3i1g5MvuMKcA+LJtypfTu4DPhio5+9vFGkAJszTY/AI0q+G/uKd2D5
         /p5+9N72MwDNM7u7lpcef4R3cdOPzIKOsyJ7Tz6nz/eLCv/fR98z5CDTnnOguB7p13hq
         5a9A==
X-Gm-Message-State: ACgBeo2GI4Y7h3XnbApKmpfwyHL3XIrzk/J3w9nEAFCx4KW+Mz5MPm82
        tjmOTidNB7pZjgm046wFdyo=
X-Google-Smtp-Source: AA6agR6eFGJtDbMiDfSBHxH2zYgfAXTpySXUYD6g0Jr7+0wSy/Y0lHWU6h+PUxJv7wehoXRH4GX42A==
X-Received: by 2002:a63:fc50:0:b0:427:a666:bfe3 with SMTP id r16-20020a63fc50000000b00427a666bfe3mr20980312pgk.547.1661286716094;
        Tue, 23 Aug 2022 13:31:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90fa])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b00172ea8ff334sm5075633plh.7.2022.08.23.13.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 13:31:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 10:31:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
Subject: Re: [PATCH 6/7] kernfs: Allow kernfs nodes to be deactivated and
 re-activated
Message-ID: <YwU5Ou78/WVqrYwS@slm.duckdns.org>
References: <20220820000550.367085-1-tj@kernel.org>
 <20220820000550.367085-7-tj@kernel.org>
 <d918a1f5-40f4-c90c-a7f5-720dcfddb89b@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d918a1f5-40f4-c90c-a7f5-720dcfddb89b@bytedance.com>
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

On Tue, Aug 23, 2022 at 01:49:07PM +0800, Chengming Zhou wrote:
> > -		if (pos->flags & KERNFS_ACTIVATED)
> > +		if (kernfs_active(pos) || (kn->flags & KERNFS_REMOVING))
> 
> May I ask a question, what's the difference between kernfs_active() and KERNFS_ACTIVATED?
> 
> KERNFS_ACTIVATED is always set when kernfs_activate() and never clear, so I think it means:
> 
> 1. !KERNFS_ACTIVATED : allocated but not activated
> 2. KERNFS_ACTIVATED && !kernfs_active() : make deactivated by kernfs_deactivate_locked()
> 
> I see most code check kernfs_active(), but two places check KERNFS_ACTIVATED, I'm not sure where
> should check KERNFS_ACTIVATED, or is there any chance we can remove KERNFS_ACTIVATED?

Yeah, ACTIVATED means taht created but never activated while kernfs_active()
means currently active. I tried to substitute all ACTIVATED tests with
kernfs_active() and remove the former but I wasn't sure about changing
kernfs_add_one() behavior.

I think it's too confusing to combine the initial activated state with
user-requested show/hide state and causes other problems like
kernfs_activate() used to activate newly created files unhiding files
explicitly deactivated. Lemme separate out show/hide state into something
separate so that the distinction is clear.

Thanks.

-- 
tejun
