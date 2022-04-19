Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604765060F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 02:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiDSAdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 20:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiDSAdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:33:00 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B8E252BC
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 17:30:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j70so1064464pgd.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Apr 2022 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QyazptfXP7Rs93K/hiFyb/6AZ61n5qOjKOHynMwC+bQ=;
        b=MPOgAg96vGHs3bRXKO17sSSDcM506EcaNoM9FZhvKTml594Xd/4b2Zb4U11WJzDMiK
         V3XOeg4wkoFb7zNI8pVGxsIyXDoqH8a9iU+jf7KMc7h+aLTyBlWS22HxeR3lKKnTbHw3
         Fe0no9m71NRV7VljRyvBGlLb4msg2dBNESrdb/TOF2GY3yzb41IyvfHsyJZxKquQtnao
         JyRbexn8Aj199OHB1fXz6P6V9B2TKKHrSOJTdeUW420hi4r3Wm3s17pqou5b3peWiA1Y
         HnYDIVXzsFzioJmKS+15sT7w1jA1X/GC+uUC2YIHdynGr2eh27oxxiXokpdqOyOILxMA
         0q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QyazptfXP7Rs93K/hiFyb/6AZ61n5qOjKOHynMwC+bQ=;
        b=f5g4f4YAO2Vg5SUllfTf4od3A1sEBp58J2pe6QuWAGIKqB9uoDs8WAtTdrwLFI+z1s
         5zUfwTLut8t3krsFIXyB+fZKRYzkYL9BiGEapX01U7hWBF+dtwfjI0okfMkgVTX2pwIy
         5awNWsTSuiqCLAYWFhtmVpUeD+p94aIMfo2EH8pmUihi/3BNSk3RNvCz5/XVoOrLqO7V
         bb5Nt2ylkMa+vzDnL0evl8AJ4f4tMrlCgw+8ywazZ2Q1PQvNIf1eogkjs+FR0TT3jtKE
         uujYDB26HuS+vDSpVCaL0f+EDsoxl0FzWdOgb9tJJFDHCJ3qKMcRCuGiEc1UtzK0+SO2
         P1Bg==
X-Gm-Message-State: AOAM532sl7qZ6C0EpiECSWF3IsLEUhzeDRUnObsE7yOjTLlKWZ1FbZoI
        HEIhQPGaNfWJjg6eCBBcYGUcrGfpC1Sf97Zo
X-Google-Smtp-Source: ABdhPJyqF0aouiLcOtGZwtlWinOEg3dMkGA3r1kxJ3cZX3kQbML50BZ0QgWtn0f9pEexp8Lm261DFw==
X-Received: by 2002:a63:ff1c:0:b0:39c:c83a:7da with SMTP id k28-20020a63ff1c000000b0039cc83a07damr12375416pgi.479.1650328218020;
        Mon, 18 Apr 2022 17:30:18 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g200-20020a6252d1000000b0050833d7602csm14011317pfb.103.2022.04.18.17.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:30:17 -0700 (PDT)
Message-ID: <69f80fe3-5bec-f02e-474b-e49651f5818f@kernel.dk>
Date:   Mon, 18 Apr 2022 18:30:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2=5d_fs-writeback=3a_writeback=5fsb=5fino?=
 =?UTF-8?Q?des=ef=bc=9aRecalculate_=27wrote=27_according_skipped_pages?=
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yukuai3@huawei.com
References: <20220418092824.3018714-1-chengzhihao1@huawei.com>
 <CAHk-=wh7CqEu+34=jUsSaMcMHe4Uiz7JrgYjU+eE-SJ3MPS-Gg@mail.gmail.com>
 <587c1849-f81b-13d6-fb1a-f22588d8cc2d@kernel.dk>
 <CAHk-=wjmFw1EBOVAN8vffPDHKJH84zZOtwZrLpE=Tn2MD6kEgQ@mail.gmail.com>
 <df4853fb-0e10-4d50-75cd-ee9b06da5ab1@kernel.dk>
 <CAHk-=wg6s5gHCc-JngKFfOS7uZUrT9cqzNDKqUQZON6Txfa_rQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wg6s5gHCc-JngKFfOS7uZUrT9cqzNDKqUQZON6Txfa_rQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/22 6:19 PM, Linus Torvalds wrote:
> On Mon, Apr 18, 2022 at 3:12 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Hmm yes. But doesn't preemption imply a full barrier? As long as we
>> assign the plug at the end, we should be fine. And just now looking that
>> up, there's even already a comment to that effect in blk_start_plug().
>> So barring any weirdness with that, maybe that's the solution.
> 
> My worry is more about the code that adds new cb_list entries to the
> plug, racing with then some random preemption event that flushes the
> plug.
> 
> preemption itself is perfectly fine wrt any per-thread data updates
> etc, but if preemption then also *changes* the data that is updated,
> that's not great.
> 
> So that worries me.

Yes, and the same is true for eg merge traversal. We'd then need to
disable preempt for that as well...

It may be the best option in terms of making this issue go away without
having callers working around it. I don't have a good answer to this
right now, I'll think about it.

-- 
Jens Axboe

