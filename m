Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7A630018
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 23:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiKRW3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 17:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiKRW3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:29:05 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6357EBDF
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 14:29:03 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso6327119pjc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 14:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbBsvDU//DL6nEBTfVogOGw4gtrIt5cEgoWU7wg0yqE=;
        b=An8R27hBelrmHfCbOWIi0CQbpB+FbdUKZd/K74OWA+t1inv8v4494buerQXpAbVoQ/
         hawXo5IWqwOaOJXIlgQJ62nY4aZ8mzIQL8T0sN5QawgAa8EGZw3klOrzN/KXycM8ohn1
         PnwiDQNXHvwQENzmlhMaoO6BFIxzwB92hREPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbBsvDU//DL6nEBTfVogOGw4gtrIt5cEgoWU7wg0yqE=;
        b=pqqG6YReHRK32DFdisxaU6IAgDSMT5xr91jJ6Z0FSN+ZfnYTj81ZkRVlmrKYSFIWNw
         GMYMVmql0j1xyTODDqW6CWNclRZSkjEqQE5QHhOT7Vm/5rDrPqySXsiiAt2eLPvD2yjU
         rj+R/cq5zxM4Trqa+8pY4946g+Lv/O5rwG+r5SOcJnlLo8Dp8yOVdRyivToWgdaBPm53
         w4l2t1Z92j3DyTgyp8LrxYUtI9UoVUlq8ugWDKQtq3lvJhkNLbcQ9K45xcN2Jj6katW+
         aVh0sWi5hfcGMeKg66hiXNeGWTioIjDw1S9Td3Sm0sugTk78/BBa487bm7JZAUz9DU5E
         viuQ==
X-Gm-Message-State: ANoB5plNWsd7ngXBBTc5LPhp9fUXSlGSC6srtq/K0ckxI9eIDllXdBPd
        HvZAHHhtJg4gQ7zwkLNZGCN8Lw==
X-Google-Smtp-Source: AA0mqf6x3WR1+0wUVWwli47/xk6od69+oUWF0cQjmoupKb1o7R1u9AWIvzDIrLxmCvQfjLJnyEjRtg==
X-Received: by 2002:a17:902:e009:b0:188:649b:9dbe with SMTP id o9-20020a170902e00900b00188649b9dbemr1414800plo.107.1668810543395;
        Fri, 18 Nov 2022 14:29:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b29-20020aa7951d000000b00561382a5a25sm3714931pfp.26.2022.11.18.14.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 14:29:02 -0800 (PST)
Date:   Fri, 18 Nov 2022 14:29:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-perf-users@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH mm-unstable v1 20/20] mm: rename FOLL_FORCE to FOLL_PTRACE
Message-ID: <202211181427.4D1C3132FE@keescook>
References: <20221116102659.70287-1-david@redhat.com>
 <20221116102659.70287-21-david@redhat.com>
 <CAHk-=wgtEwpR-rE_=cXzecHMZ+zgrx5zf9UfvH0w-mKgckn4=Q@mail.gmail.com>
 <Y3dnzgwJpjTQXI9y@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3dnzgwJpjTQXI9y@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022 at 12:09:02PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 16, 2022 at 10:16:34AM -0800, Linus Torvalds wrote:
> > Following the history of it is a big of a mess, because there's a
> > number of renamings and re-organizations, but it seems to go back to
> > 2007 and commit b6a2fea39318 ("mm: variable length argument support").
> 
> I went back and read parts of the discussions with Ollie, and the
> .force=1 thing just magically appeared one day when we were sending
> work-in-progress patches back and forth without mention of where it came
> from :-/
> 
> And I certainly can't remember now..
> 
> Looking at it now, I have the same reaction as both you and Kees had, it
> seems entirely superflous. So I'm all for trying to remove it.

Thanks for digging through the history! I've pushed the change to -next:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/execve&id=cd57e443831d8eeb083c7165bce195d886e216d4

-- 
Kees Cook
