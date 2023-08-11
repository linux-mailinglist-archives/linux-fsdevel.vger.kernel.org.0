Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2137791E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 16:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjHKObv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 10:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjHKObu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:31:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE3D2D43
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 07:31:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdb3ecd20dso1438435ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691764310; x=1692369110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GKhOCnnchifhHLTb0280rbn5Lcbt1RL2SPwHXYKnIM=;
        b=vXcU6XvKxPEhGz4d9rgaN+cguw0vNFNzb3HLDrP1zKm1tpi5+Nq4oKmt2Wd6y5DG4x
         ToSqjLm0dyyqDC7EHNbmH9JUYJ4dbQiEaOb2YBfGFx5lAGTWp++6f7Dij0CzLQrGMKTy
         iidyVsv+NIYLEgV707cMDm9CLfja1V8tKSQnuefLnwoHLT3hUiuX4V5FSGXDide9mLx/
         +vYTmMcUx2qjM/em5+ZTunMuzdeH08CUQzgU7pcKt5HdfH/qfxQLTDpo8qZd6UbK20My
         BgrswTEBXFyiBcOk0nbRIQNfZYLltSsBW9fu3DMj/LtsmA29uHeqiJ8Dqd9WH0PwQlfi
         CFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691764310; x=1692369110;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GKhOCnnchifhHLTb0280rbn5Lcbt1RL2SPwHXYKnIM=;
        b=IGoRGaAz/NHTOutApiesgKX5eGI4vvGOH2vfa+eYtp1OzdhkfMzbXeUzYQACLUf9C0
         c2jIlNKG5q6DE2l5cl8Wya5mMDLwExvPuqs2M8ZI+x8Zl6ZSM1TIXdxG8+RuQNrh2H6H
         rn0MbNvqX7OZK9RXB9Q0Yq+70kXI9FzHj450VrbubBaTa8yQ20OB8uShVbWz8vD2RjRh
         jjrr4UirOERM8E7JlWXlZrmLBT8NS0coRQEqjfxXZok4ZzG1Ke+e38/CWJBGm8c2etc8
         jme3ArAsVd+avAI8X/wLmoGLaFlk+R1u50uXHkAMYxc8NmTU4I0ADewv/bSzlps5NHmo
         yxCw==
X-Gm-Message-State: AOJu0Yww0WXrv0nzjh6EO6agDUi5U3hAAjDZr2FjdnRy94OEJBVecVbW
        1uHt2Z5zYQL56//ulisGw+5HBQ==
X-Google-Smtp-Source: AGHT+IFCiEAfjFbH0W9VXBgSjjFn2TQb45Nbv3UPs9HVtHvFo+OqryksH1T+mBClvkF/eUwvjCsVZQ==
X-Received: by 2002:a17:902:d4ce:b0:1b1:9272:55e2 with SMTP id o14-20020a170902d4ce00b001b1927255e2mr2547329plg.3.1691764309829;
        Fri, 11 Aug 2023 07:31:49 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090abe0100b00268040bbc6asm5319997pjs.4.2023.08.11.07.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 07:31:48 -0700 (PDT)
Message-ID: <18264001-ca5c-465b-bccf-c1b67319b203@kernel.dk>
Date:   Fri, 11 Aug 2023 08:31:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, dchinner@redhat.com,
        sandeen@redhat.com, willy@infradead.org, josef@toxicpanda.com,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, brauner@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com, snitzer@kernel.org
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230712025459.dbzcjtkb4zem4pdn@moria.home.lan>
 <CAHk-=whaFz0uyBB79qcEh-7q=wUOAbGHaMPofJfxGqguiKzFyQ@mail.gmail.com>
 <20230810155453.6xz2k7f632jypqyz@moria.home.lan>
 <20230810223942.GG11336@frogsfrogsfrogs>
 <CAHk-=wj8RuUosugVZk+iqCAq7x6rs=7C-9sUXcO2heu4dCuOVw@mail.gmail.com>
 <20230811040310.c3q6nml6ukwtw3j5@moria.home.lan>
 <CAHk-=whDuBPONoTMRQn2aX64uYTG5E3QaZ4abJStYRHFMMToyw@mail.gmail.com>
 <20230811052922.h74x6m5xinil6kxa@moria.home.lan>
 <CAHk-=wiJ0xo2_aqVCoJHnO_AYP=cy1E8Pk5Vxb13+nFastAFEQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiJ0xo2_aqVCoJHnO_AYP=cy1E8Pk5Vxb13+nFastAFEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/10/23 11:53 PM, Linus Torvalds wrote:
> On Thu, 10 Aug 2023 at 22:29, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>>
>> On Thu, Aug 10, 2023 at 10:20:22PM -0700, Linus Torvalds wrote:
>>> If it's purely "umount doesnt' succeed because the filesystem is still
>>> busy with cleanups", then things are much better.
>>
>> That's exactly it. We have various tests that kill -9 fio and then
>> umount, and umount spuriously fails.
> 
> Well, it sounds like Jens already has some handle on at least one
> io_uring shutdown case that didn't wait for completion.
> 
> At the same time, a random -EBUSY is kind of an expected failure in
> real life, since outside of strictly controlled environments you could
> easily have just some entirely unrelated thing that just happens to
> have looked at the filesystem when you tried to unmount it.
> 
> So any real-life use tends to use umount in a (limited) loop. It might
> just make sense for the fsstress test scripts to do the same
> regardless.
> 
> There's no actual good reason to think that -EBUSY is a hard error. It
> very much can be transient.

Indeed, any production kind of workload would have some kind of graceful
handling for that. That doesn't mean we should not fix the delayed fput
to avoid it if we can, just that it might make sense to have an xfstest
helper that at least tries X times with a sync in between or something
like that.

-- 
Jens Axboe

