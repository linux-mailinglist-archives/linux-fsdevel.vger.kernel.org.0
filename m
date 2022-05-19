Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD3752CB1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 06:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiESEbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 00:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiESEax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 00:30:53 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD62CCB2;
        Wed, 18 May 2022 21:30:52 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id n13so5685181ejv.1;
        Wed, 18 May 2022 21:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P5Osd3sPaknEExVr4uQcy7IV13D6p6p8yYGCA/bsUZ8=;
        b=PPV/NM9Py6DccKrD5BGefcKkksH+9A+Z7jfvgIsBxilGYKcQyiDVSjrC+2pXl1tKD+
         N7yUBmzj0yagDJC+N6+hRKt/bNaudWQgEcRvemQUaiHNDWRbjiV8NWn1QQfZ7T6UtbQ+
         tftStw3u70jkZq4Zed/xHfUcyoXIWrhhMKaUEriMfB39jI8vFCH0UOncsB9tVqAmPNnd
         cLDJiCpn+6sPhMuFEoD1ZKypPFFOiUtw4DrU11kpY0ZnaSkwYeiakghrnAt+8sUQ9C9o
         0jc7yneuMQekUWcj1y5hauQ84GENdHUttgKYH364/+jz0nEH7h9koaYijBAq7WGpMrIa
         EFeA==
X-Gm-Message-State: AOAM531cCaPya51SEund0rdrowrjDbf8ZTHbvy9INpcn/QISYJOBvf+X
        fIXTKDMcOGC6t4CznN2La30=
X-Google-Smtp-Source: ABdhPJx0+FzMx4zrx/RSl04CX5erCA3gCyo4iEot31qezyjZorqaB5olpAkj8FKsVNIA/EigmIM1MA==
X-Received: by 2002:a17:907:972a:b0:6f4:f456:50a7 with SMTP id jg42-20020a170907972a00b006f4f45650a7mr2433296ejc.431.1652934650880;
        Wed, 18 May 2022 21:30:50 -0700 (PDT)
Received: from [192.168.50.14] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id hx25-20020a170906847900b006f3ef214df2sm1655454ejc.88.2022.05.18.21.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 21:30:50 -0700 (PDT)
Message-ID: <36d2cb9b-43cd-36f6-422d-2c2199666d58@acm.org>
Date:   Thu, 19 May 2022 06:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv2 2/3] block: export dma_alignment attribute
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        damien.lemoal@opensource.wdc.com, Keith Busch <kbusch@kernel.org>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-3-kbusch@fb.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220518171131.3525293-3-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/22 19:11, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> User space may want to know how to align their buffers to avoid
> bouncing. Export the queue attribute.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/blk-sysfs.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 88bd41d4cb59..14607565d781 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -274,6 +274,11 @@ static ssize_t queue_virt_boundary_mask_show(struct request_queue *q, char *page
>   	return queue_var_show(q->limits.virt_boundary_mask, page);
>   }
>   
> +static ssize_t queue_dma_alignment_show(struct request_queue *q, char *page)
> +{
> +	return queue_var_show(queue_dma_alignment(q), page);
> +}
> +
>   #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
>   static ssize_t								\
>   queue_##name##_show(struct request_queue *q, char *page)		\
> @@ -606,6 +611,7 @@ QUEUE_RO_ENTRY(queue_dax, "dax");
>   QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
>   QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
>   QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
> +QUEUE_RO_ENTRY(queue_dma_alignment, "dma_alignment");
>   
>   #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
>   QUEUE_RW_ENTRY(blk_throtl_sample_time, "throttle_sample_time");
> @@ -667,6 +673,7 @@ static struct attribute *queue_attrs[] = {
>   	&blk_throtl_sample_time_entry.attr,
>   #endif
>   	&queue_virt_boundary_mask_entry.attr,
> +	&queue_dma_alignment_entry.attr,
>   	NULL,
>   };

Please add an entry for the new sysfs attribute in 
Documentation/ABI/stable/sysfs-block.

Thanks,

Bart.
