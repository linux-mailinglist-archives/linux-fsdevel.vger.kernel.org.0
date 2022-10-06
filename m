Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6CB5F71C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiJFX1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiJFX1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:27:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82306EB7C1
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 16:27:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 195so3180281pga.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 16:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=G+pKJ+NYwNy31R5rVBG8O8KRq78K+Bn0ef6gLvXvUsE=;
        b=cyvZiiLNNQN/k/ffseKyT75ziBYKP8mMW8GgUSdfuh4H9u968RjQEtqo+5U2ngbvc1
         0pU7TY2xZIfb2TNiAO3CEn6l9kV0bj4tfD85+rPCLL79EQbQypkn+nDCpXTC54wOrPLF
         4x+JWeZIj6SUVDu1yIu2GtFF1oCEKHS3gE70c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=G+pKJ+NYwNy31R5rVBG8O8KRq78K+Bn0ef6gLvXvUsE=;
        b=wMOtnDLDEqouidMXsd5LZAo2agZDbCp9zMSD+zeNsHtPpOG+ITsE7mAW3Nyu9W3X5w
         DMrZYBIv+RQwG6k75UhTf6ngkLITtS8BF+4WP1AHPbNaUPiBhuS32lsc5e9Q13wS2bnU
         r4njUkhlxGGg34uGRT0ohizTo3eCDQXleFANJVgANOtSQuclvsXcgi/AIRfpckitmk9g
         eCmB4I30eWRnOUbu6yDrQVUD+LJ3xlxexR//0obGFSfDFjjGxSrXPX1yc6CZdAdEOkP0
         CQJbtJXGrHsRVuDrDfXc2ubKSGbDR2Yfx0KjsfUsOUVHkU/qnr9dHD9cQPVHa0LYT9Ui
         yglQ==
X-Gm-Message-State: ACrzQf1/z2F4AZEAvE/44bziJfB5LcBHeuC7RfVm/4U0999xvnTWIDah
        UV5M1870edEwJ7c0RBbGY3imZA==
X-Google-Smtp-Source: AMsMyM7Dh5gIik0oCV+rNcPk/jkO5KvagJw7jfvcTcHLDZ8w5pInyy8EkJNKnQV5CdgCnhfSVJ6zMQ==
X-Received: by 2002:a63:2f45:0:b0:457:dc63:68b4 with SMTP id v66-20020a632f45000000b00457dc6368b4mr1930448pgv.228.1665098826001;
        Thu, 06 Oct 2022 16:27:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79686000000b00540d03f3792sm172347pfk.81.2022.10.06.16.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:27:05 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:27:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Subject: Re: [PATCH 4/8] pstore: Alert on backend write error
Message-ID: <202210061625.950B43C119@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-5-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006224212.569555-5-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 07:42:08PM -0300, Guilherme G. Piccoli wrote:
> The pstore dump function doesn't alert at all on errors - despite
> pstore is usually a last resource and if it fails users won't be
> able to read the kernel log, this is not the case for server users
> with serial access, for example.
> 
> So, let's at least attempt to inform such advanced users on the first
> backend writing error detected during the kmsg dump - this is also
> very useful for pstore debugging purposes.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  fs/pstore/platform.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 06c2c66af332..ee50812fdd2e 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -463,6 +463,9 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>  		if (ret == 0 && reason == KMSG_DUMP_OOPS) {
>  			pstore_new_entry = 1;
>  			pstore_timer_kick();
> +		} else {
> +			pr_err_once("backend (%s) writing error (%d)\n",
> +				    psinfo->name, ret);

We're holding a spinlock here, so doing a pr_*() call isn't a great
idea. It's kind of not a great idea to try to write to the log in the
middle of a dump either, but we do attempt it at the start.

Perhaps keep a saved_ret or something and send it after the spin lock is
released?

-- 
Kees Cook
