Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751C977956A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjHKQ6Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjHKQ6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:58:25 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14D030C4;
        Fri, 11 Aug 2023 09:58:24 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-56d75fb64a6so415816eaf.0;
        Fri, 11 Aug 2023 09:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773104; x=1692377904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VvzFvdraEO195DSRyKfwzhYtZjNnrGvLR0U45hfcrI=;
        b=Kj72t7DQJRDzKo4qhscrldMXLR9vpGTtnUrURefX8wvPmXMkFzxGZTZM+98XppY4AM
         t+aS2PtiYil2+Tzt0RXFwvHlgc6EWpF5IhMlQGM3rfb1+Whh0KtXdbAlRSN+fJOekzXE
         lg4Nm+8SJj30D7UCWr8TWDM+Eu9mpuUS0x5lM1pngfkiSqeZS4xd9hK4UD3NksnDt4v8
         wM/yd70yOVCfyZrYgYyTbfeGW6YggYEEKf/Vf4UIzWbfAVeF1C/APA4L/xByBBamBQJO
         22SbyokUIO8Q1r+l1lmapA08kO3RCaL+H/v/e5rwteF1If7UdYLc77g8Vusfwz/tVzXQ
         Atug==
X-Gm-Message-State: AOJu0YxZf9SdDYkyRnywKT5iO5ibtyAorwV3tXIROjycm1xFDMqGk4ie
        MuwVyVxPq8s8Gq0fdViRkES/mXdeLRSO8UROjWk=
X-Google-Smtp-Source: AGHT+IE2PrstuZZuekdTu1Ir9/Dd8rLqox3w1rJ6BrpndqICe6ITX+Oqb6eeMW6+cOVRuMvVCMvZeFgvfFX/kkaqJqs=
X-Received: by 2002:a05:6820:1687:b0:566:951e:140c with SMTP id
 bc7-20020a056820168700b00566951e140cmr2302088oob.1.1691773104132; Fri, 11 Aug
 2023 09:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230810171429.31759-1-jack@suse.cz> <20230811110504.27514-17-jack@suse.cz>
In-Reply-To: <20230811110504.27514-17-jack@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 18:58:13 +0200
Message-ID: <CAJZ5v0i6UsfYFoKdgd-RN9yMS1Nwjt0uKxhoS25vhah2d47cZw@mail.gmail.com>
Subject: Re: [PATCH 17/29] PM: hibernate: Drop unused snapshot_test argument
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 1:05 PM Jan Kara <jack@suse.cz> wrote:
>
> snapshot_test argument is now unused in swsusp_close() and
> load_image_and_restore(). Drop it
>
> CC: linux-pm@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/power/hibernate.c | 14 +++++++-------
>  kernel/power/power.h     |  2 +-
>  kernel/power/swap.c      |  6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e1b4bfa938dd..6abeec0ae084 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -684,7 +684,7 @@ static void power_down(void)
>                 cpu_relax();
>  }
>
> -static int load_image_and_restore(bool snapshot_test)
> +static int load_image_and_restore(void)
>  {
>         int error;
>         unsigned int flags;
> @@ -694,12 +694,12 @@ static int load_image_and_restore(bool snapshot_test)
>         lock_device_hotplug();
>         error = create_basic_memory_bitmaps();
>         if (error) {
> -               swsusp_close(snapshot_test);
> +               swsusp_close();
>                 goto Unlock;
>         }
>
>         error = swsusp_read(&flags);
> -       swsusp_close(snapshot_test);
> +       swsusp_close();
>         if (!error)
>                 error = hibernation_restore(flags & SF_PLATFORM_MODE);
>
> @@ -788,7 +788,7 @@ int hibernate(void)
>                 pm_pr_dbg("Checking hibernation image\n");
>                 error = swsusp_check(snapshot_test);
>                 if (!error)
> -                       error = load_image_and_restore(snapshot_test);
> +                       error = load_image_and_restore();
>         }
>         thaw_processes();
>
> @@ -952,7 +952,7 @@ static int software_resume(void)
>         /* The snapshot device should not be opened while we're running */
>         if (!hibernate_acquire()) {
>                 error = -EBUSY;
> -               swsusp_close(false);
> +               swsusp_close();
>                 goto Unlock;
>         }
>
> @@ -973,7 +973,7 @@ static int software_resume(void)
>                 goto Close_Finish;
>         }
>
> -       error = load_image_and_restore(false);
> +       error = load_image_and_restore();
>         thaw_processes();
>   Finish:
>         pm_notifier_call_chain(PM_POST_RESTORE);
> @@ -987,7 +987,7 @@ static int software_resume(void)
>         pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
>         return error;
>   Close_Finish:
> -       swsusp_close(false);
> +       swsusp_close();
>         goto Finish;
>  }
>
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 46eb14dc50c3..bebf049a51c1 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -172,7 +172,7 @@ int swsusp_check(bool snapshot_test);
>  extern void swsusp_free(void);
>  extern int swsusp_read(unsigned int *flags_p);
>  extern int swsusp_write(unsigned int flags);
> -void swsusp_close(bool snapshot_test);
> +void swsusp_close(void);
>  #ifdef CONFIG_SUSPEND
>  extern int swsusp_unmark(void);
>  #endif
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index b475bee282ff..17e0dad5008e 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -444,7 +444,7 @@ static int get_swap_writer(struct swap_map_handle *handle)
>  err_rel:
>         release_swap_writer(handle);
>  err_close:
> -       swsusp_close(false);
> +       swsusp_close();
>         return ret;
>  }
>
> @@ -509,7 +509,7 @@ static int swap_writer_finish(struct swap_map_handle *handle,
>         if (error)
>                 free_all_swap_pages(root_swap);
>         release_swap_writer(handle);
> -       swsusp_close(false);
> +       swsusp_close();
>
>         return error;
>  }
> @@ -1567,7 +1567,7 @@ int swsusp_check(bool snapshot_test)
>   *     swsusp_close - close swap device.
>   */
>
> -void swsusp_close(bool snapshot_test)
> +void swsusp_close(void)
>  {
>         if (IS_ERR(hib_resume_bdev_handle)) {
>                 pr_debug("Image device not initialised\n");
> --
> 2.35.3
>
