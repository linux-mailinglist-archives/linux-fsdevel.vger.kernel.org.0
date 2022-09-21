Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E5E5E53CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 21:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiIUTaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 15:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiIUTaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:30:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B86298A78
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 12:30:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u18so10896473lfo.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dUp34wU+rIvE4FOjS5Am/ggzUEg/7JO0XLgISf2jrDw=;
        b=LGZQUM5uwNtvfEAnEipVUgYMt8A/QPJi5hFGTf7gwQ6wrDOPADB7dHS4qztxecH83g
         HN3PlnCcmM2S+9Dqtj0e+4k76s3izpY45yp+vTPj8lW+5Mom7CnGmud1TWNxhpcltpO6
         iFtf5vWOUHTxYoSdIlX6Ak9KxNt8fv7V2e3dDVnJiM0PRIWjNgt308OIYxchyRJc22xa
         wfsr2ZsmSJ3yLWEMyGQalEMQ94cejM8fZMnVDqI3muwy09C3+DpcLntI/iBAN1nPVKhU
         OBcnz7eyyomdZ6/bWSyPqffGe/B9xUM7LHpFZ/BgygwY/J42u0tcpHt1xz2lweAogtPN
         2pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dUp34wU+rIvE4FOjS5Am/ggzUEg/7JO0XLgISf2jrDw=;
        b=B2EcXwUg95+Ff7PhHqh5wxAr+V8lcnsbvOsdYPtpZweBFW2pT0xG3ffdLaWOx8DBL5
         4k8Y+AaJddHzV9Vuo4k2EhKqICdDLKHhe+fi3XaEhBjyoCZsp6IDs9r9qo46J93NXA8r
         dMZlwWu4tPGTVb91etcSiLKSEzQjfO74ohp/8746XjKOGrhKsX5xgiaWiIzYJDuY3kQF
         bnWeuo6VybGGt5Ad1QKvNzAdrZxaYHVE3paCXlN5c5p/xf2QLmeLxNDj/AV+OrudJNvp
         uuU0LpkmWv/y+hIkR1eBGZctmSYfLMTP2yRivPUBEPLPTu0tCfSJ2PoUwa5r9bJo591V
         JgjA==
X-Gm-Message-State: ACrzQf06/Zefk44zrRTMcfPJ6F+nyfMl4baI8pW4+Ufvp8kgtVfMrb4a
        3ENEthyZlyu8mGAOP++h7MWYEGodLETcsZArty7mg91HhH0=
X-Google-Smtp-Source: AMsMyM4UjQA3cdxDZHWf6B8Ig1L9lp1kN2mKmfQIDi7llbNq2QI0D/11Csj2bu9m2IEMtgRC8FBiF9mNgEoT6WvdSzo=
X-Received: by 2002:a05:6512:12d6:b0:49f:48d4:a1c4 with SMTP id
 p22-20020a05651212d600b0049f48d4a1c4mr10901513lfg.52.1663788616355; Wed, 21
 Sep 2022 12:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <YwFANLruaQpqmPKv@ZenIV> <YwFCIkDT7sFO1D9N@ZenIV>
In-Reply-To: <YwFCIkDT7sFO1D9N@ZenIV>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Wed, 21 Sep 2022 15:30:05 -0400
Message-ID: <CAOg9mSQwjKVDJLCHLTpQyAWkCoaAA37U0LkyG6AqvmYdZP_JnA@mail.gmail.com>
Subject: Re: [PATCH 8/8] orangefs: use ->f_mapping
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Mike Marshall <hubcapsc@gmail.com>, devel@lists.orangefs.org
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I added this patch to one of the 6.0 rc's that I've been
running through xfstests, no regressions... so...

You can add tested by me if you'd like...

Thanks!

-Mike


On Sat, Aug 20, 2022 at 4:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ... and don't check for impossible conditions - file_inode() is
> never NULL in anything seen by ->release() and neither is its
> ->i_mapping.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/orangefs/file.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
> index 86810e5d7914..732661aa2680 100644
> --- a/fs/orangefs/file.c
> +++ b/fs/orangefs/file.c
> @@ -417,9 +417,7 @@ static int orangefs_file_release(struct inode *inode, struct file *file)
>          * readahead cache (if any); this forces an expensive refresh of
>          * data for the next caller of mmap (or 'get_block' accesses)
>          */
> -       if (file_inode(file) &&
> -           file_inode(file)->i_mapping &&
> -           mapping_nrpages(&file_inode(file)->i_data)) {
> +       if (mapping_nrpages(file->f_mapping)) {
>                 if (orangefs_features & ORANGEFS_FEATURE_READAHEAD) {
>                         gossip_debug(GOSSIP_INODE_DEBUG,
>                             "calling flush_racache on %pU\n",
> --
> 2.30.2
>
