Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E95B4611
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 13:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiIJLcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIJLcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 07:32:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34DD53026
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 04:32:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t5so6134877edc.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 04:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oO2f6puxNv2WM0203jHJ9dATLxOnB/EAhNK0gKh1Fco=;
        b=ZH5YuCofNtiX91aOQ8okF8wGG31vLQnBuGTbsJIxq6skqZDH7RvK+S6Wg/jL8kGMG0
         wxALhNndMloVN1pmlZYgbSnkA4WugVPm6xPyUnDyPXtNQrabmBlb3doY3JHFHpEwdDOn
         UCMlcq27n8LGY/fiI8rrezsaIzsFdm7yeal6QiEIrx2i6u5RSvNr3NejNRbuoylCf6VT
         1NmPWSzvA4lzXHfElWpQVZrWn1GOb5l1rdycwSX1lGO4Q9iha+7RREdHfUFuABmzTqNy
         MS6wyNdM+htzk0aYqzebY8yDNHwmUT2SYl/24SW+F1b30ss1/TkgEA7qVOS7cSXPX2Wb
         gdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oO2f6puxNv2WM0203jHJ9dATLxOnB/EAhNK0gKh1Fco=;
        b=fynOVT+LKD+KXASVlGsPbVRFz2A4u45qzy18A3O0dilY8mvsgFatx9/pWrRWAW31Q4
         2xf8qgiBYSuLi/wk9qMvSTyy/WlhzzIKbVoSIkO1UJh0TlIFAdXoQ43XP24mico1/4Dn
         SUTLYz0LnjgtzXVvY8VdacDmxY9kZrzaKQgBxlDFVIgpuww00jc/ePFydSX+d9Zcaju/
         ykEZEHZqeOf23H5FgPa284FqKxSpKzwdRlp32DVdpeIW8+PDAPXpFdT7jFnS9ywX/vLx
         C6bMCAfwMP1bYTFrkOrXTQI5b0+/YgPpadzwYS5PrydvmANw7aluRSe/jcKpaVcDyr5G
         /xqQ==
X-Gm-Message-State: ACgBeo00L4x4Ie8xbo2K5dxtaem70LyOTMjhjOP+w0Lo+lsu3w56QaEa
        PV/M49YemT2ka9PE+gFjuvaZOA==
X-Google-Smtp-Source: AA6agR7ABzhvw0hLX7UM5YEGmj7ooKpj1BWh9U8hMic6ls9gEZTIgOqBBSoD7neml/f66zDsZ4trLA==
X-Received: by 2002:a05:6402:280f:b0:44e:ee5c:da6b with SMTP id h15-20020a056402280f00b0044eee5cda6bmr15219418ede.256.1662809547250;
        Sat, 10 Sep 2022 04:32:27 -0700 (PDT)
Received: from [10.41.110.194] ([77.241.232.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b00731582babcasm1625186eja.71.2022.09.10.04.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 04:32:26 -0700 (PDT)
Message-ID: <c76b45ad-c4ef-5166-fec3-a05e2febcce3@kernel.dk>
Date:   Sat, 10 Sep 2022 05:32:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: improve pagecache PSI annotations
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
References: <20220910065058.3303831-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220910065058.3303831-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/22 12:50 AM, Christoph Hellwig wrote:
> Hi all,
> 
> currently the VM tries to abuse the block layer submission path for
> the page cache PSI annotations.  This series instead annotates the
> ->read_folio and ->readahead calls in the core VM code, and then
> only deals with the odd direct add_to_page_cache_lru calls manually.
> 
> Diffstat:
>  block/bio.c               |    8 --------
>  block/blk-core.c          |   17 -----------------
>  fs/btrfs/compression.c    |   14 ++++++++++++--
>  fs/direct-io.c            |    2 --
>  fs/erofs/zdata.c          |   13 ++++++++++++-
>  include/linux/blk_types.h |    1 -
>  include/linux/pagemap.h   |    2 ++
>  kernel/sched/psi.c        |    2 ++
>  mm/filemap.c              |    7 +++++++
>  mm/readahead.c            |   22 ++++++++++++++++++----
>  10 files changed, 53 insertions(+), 35 deletions(-)

Nice! It's always bothered me that we have this weird layering
here.

-- 
Jens Axboe


