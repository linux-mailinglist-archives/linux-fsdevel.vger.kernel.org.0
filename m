Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC254CEE47
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 23:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiCFW5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 17:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiCFW5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 17:57:24 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFCA5D19F
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Mar 2022 14:56:30 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id k2so13472803oia.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Mar 2022 14:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Dmdy+i3uT1vMTjIIUUGxY356tL80CQPC7DAppRvN/v4=;
        b=RHlAsrw54Syc2b71XmoAgc9tMoyxPncID+HTKRbKcPDoK+nb2lLb2KMUJ5oatezqJp
         kIQQ8j+85C2WVQdSEoPVsTdpnTeNe6L0drMxTDR5fKK4Rwz2TBrpJPh6lga7htOXgfQ1
         vDHAHgP9kvM4alxHv9ZA+Tl7hsCTw7YIfzWx/5BPHvGXkG2qQVM08N9oKF00/EW+oXMM
         VuaZpiO/OTsdaZMjQ10HiMDEaXlnhDwdKoyeJAUq+EhwftYbc+K/9nzQyZXPjd2T4wRQ
         LDVLSnZzumNt9ZjmCBpyqDDGcuCfBtuh5jU4S6yqquMYTxfKnYDL4OT6gqhQWFFRiRsF
         O1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Dmdy+i3uT1vMTjIIUUGxY356tL80CQPC7DAppRvN/v4=;
        b=q8Fx0z1rtGQ+y6P5/J063PFiWjjpnFMh3l6uuRKOxBzX8CfS8uLUKCY6hkVACe5vsg
         v61Pa/tOb3YaMX5GmpUAUnhpmeQM5RpVxlnIYB9qrTtHnny5qrKWB/fKTMaU6QKDmGir
         SN2K0SWHjuXDsAjPgjAUYyrKayBQqa2rxW93fpdA2ZwrktFKVryuw+mHyhvtu8yDb7Tf
         S7QxjjPaKfvgBYIvy5Pje5gfss2frtDcvXjKPARP7UHtBs0Z0ALbkpcuwN06Ss6icuLy
         cRV7ozUYxXceeXdc76EkxEoAUP8kVcz7gC6GsgKC8m5qWvwCaNZ9xemc5U5Corkvp3tG
         +JMg==
X-Gm-Message-State: AOAM531EalFbLcQIZyCp7LqpIAbX3uit++tjcuQikULo1tcfiFDBZLOc
        6KnthKN+laGc18w8LNoM5JHEmw==
X-Google-Smtp-Source: ABdhPJywLyJhZyD9J9gY8eJAMWK13um1KkbIWUiUudShTIbdvipbiaXew6S5+74+8I/+oUq8A7Ry0g==
X-Received: by 2002:a05:6808:1201:b0:2d9:a01a:48b8 with SMTP id a1-20020a056808120100b002d9a01a48b8mr5756240oil.259.1646607389518;
        Sun, 06 Mar 2022 14:56:29 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b63-20020acab242000000b002d9ddf4596fsm238029oif.49.2022.03.06.14.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 14:56:28 -0800 (PST)
Date:   Sun, 6 Mar 2022 14:56:16 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Christoph Hellwig <hch@lst.de>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Borislav Petkov <bp@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] tmpfs: do not allocate pages on read
In-Reply-To: <20220306092709.GA22883@lst.de>
Message-ID: <c3af6df8-af19-1b2-5f15-e4b69a31bc33@google.com>
References: <f9c2f38f-5eb8-5d30-40fa-93e88b5fbc51@google.com> <20220306092709.GA22883@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 6 Mar 2022, Christoph Hellwig wrote:
> On Fri, Mar 04, 2022 at 09:09:01PM -0800, Hugh Dickins wrote:
> > It's not quite as simple as just removing the test (as Mikulas did):
> > xfstests generic/013 hung because splice from tmpfs failed on page not
> > up-to-date and page mapping unset.  That can be fixed just by marking
> > the ZERO_PAGE as Uptodate, which of course it is; doing so here in
> > shmem_file_read_iter() is distasteful, but seems to be the best way.
> 
> Shouldn't we set ZERO_PAGE uptodate during early init code as it, uh,
> is per definition uptodate all the time?

You're right, that does look hacky there.  I was too unsure of when and
how the different architectures set up ZERO_PAGE, so kept away.  But
looking through, pagecache_init() seems late enough in initialization
and early enough in running, and an appropriate place to do it -
tmpfs may be the first to need it, but it could be useful to others.
Just on ZERO_PAGE(0), the one used all over: never mind the other
colours of zero page, on those architectures which have multiple.

v2 coming up.

> 
> > 
> > My intention, though, was to stop using the ZERO_PAGE here altogether:
> > surely iov_iter_zero() is better for this case?  Sadly not: it relies
> > on clear_user(), and the x86 clear_user() is slower than its copy_user():
> > https://lore.kernel.org/lkml/2f5ca5e4-e250-a41c-11fb-a7f4ebc7e1c9@google.com/
> 
> Oh, that's sad as just using clear_user would be the right thing to
> here.
> 
> > But while we are still using the ZERO_PAGE, let's stop dirtying its
> > struct page cacheline with unnecessary get_page() and put_page().
> > 
> > Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> > Reported-by: Lukas Czerner <lczerner@redhat.com>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> But except for maybe making sure that ZERO_PAGE is always marked
> uptodate this does looks good to me.

Thanks a lot for looking through.

Hugh
