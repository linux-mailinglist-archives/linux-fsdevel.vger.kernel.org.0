Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93A9777FE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 20:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjHJSE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 14:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjHJSEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:04:25 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42BA10D;
        Thu, 10 Aug 2023 11:04:24 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-641897222f6so3216446d6.0;
        Thu, 10 Aug 2023 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691690664; x=1692295464;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VG/uNlFyJja7lEeGuDWud0yyTYi4B3i+dZ9t+Phv10Q=;
        b=hf0NSxR3RI1WzWVNkqda1sm2CG+5J7s7P7Hr1Zx5um0AJMym26kgHwQUmjvyoDai81
         PDHBzDBa/lNn8anDK8oTvF/JItcim9ZM79xO09WIN+keMLwhrm5qGxdx9HPwl3JSKEt5
         3jTkVdiYDYa3i+VtTTZFNEN6R00cX0IEaWaLu6Jof+HpL6NgeH31L5O7TtwQFH37OxGe
         exDuRjfhEsZxQeJB1EKqKpMPcDisevhnibU3mdkCBVN1CubLBwuh9ja+IrC+8vPuav02
         9GUAh2BfJsX3YcKl9UGf8rsccZh72z4MuEKV2qaWrlVzTfZ2wzD6+AxWJbM76IT31sni
         DtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690664; x=1692295464;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG/uNlFyJja7lEeGuDWud0yyTYi4B3i+dZ9t+Phv10Q=;
        b=GMz9MwESbtWF1q+QhPDUqbQlDFo6aPbYgwjRQMH/VDKh7qvK82MzAJkTaTQQ0vHdJb
         ZriSunpwU2CPGQHWd4Ysu5zhHev3wze0YVy7+PB/AQGZzlSCiVgE7D5ScRCaM7jVJysX
         WJ/rk31iMw0ks2L16BD9Wr4RJOj2wx48hRvKzSHxcjilgTDJSJj+CiHemXvKpiL0nMVA
         ceQ918KYcrn5EMN4fb9FQrat+Odh+J6suK41iyM9QNIkz0V30oPYCRXl8gUkRO/SrRKa
         T+O3ER2zazawt5fqlOYDlCS3Mf5V8y0tAeSfZv47tEBLzdfaHC4DtkqgMXGkQgJzqX4k
         1MzQ==
X-Gm-Message-State: AOJu0YynV1A56pguWa6dB7VVNsPBcFshi9wskBcf+Pzc2lXjkYxLQ7nq
        eHDNCcfGNS34pBb7JAJeP+nJw809dnyVug==
X-Google-Smtp-Source: AGHT+IG+to/iQLxRFKooWmEc2CIWVKeHrI/DWNki1AnIqFj45PNtbTewnLv0CldBOBjFC1sm5/0eDw==
X-Received: by 2002:a0c:ca0f:0:b0:63d:6df9:d166 with SMTP id c15-20020a0cca0f000000b0063d6df9d166mr2957557qvk.4.1691690663855;
        Thu, 10 Aug 2023 11:04:23 -0700 (PDT)
Received: from [172.16.0.69] (c-67-184-72-25.hsd1.il.comcast.net. [67.184.72.25])
        by smtp.gmail.com with ESMTPSA id q29-20020a05620a039d00b0076c96e571f3sm652737qkm.26.2023.08.10.11.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:04:23 -0700 (PDT)
Sender: Frank Sorenson <frank.sorenson@gmail.com>
From:   Frank Sorenson <frank@tuxrocks.com>
X-Google-Original-From: Frank Sorenson <sorenson@redhat.com>
Message-ID: <85cc0147-2fd0-de22-4ff6-57705983c968@redhat.com>
Date:   Thu, 10 Aug 2023 13:04:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] fat: remove i_version handling from fat_update_time
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
 <20230810-ctime-fat-v1-1-327598fd1de8@kernel.org>
Content-Language: en-US
In-Reply-To: <20230810-ctime-fat-v1-1-327598fd1de8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/10/23 08:12, Jeff Layton wrote:
> commit 6bb885ecd746 (fat: add functions to update and truncate
> timestamps appropriately") added an update_time routine for fat. That
> patch added a section for handling the S_VERSION bit, even though FAT
> doesn't enable SB_I_VERSION and the S_VERSION bit will never be set when
> calling it.
>
> Remove the section for handling S_VERSION since it's effectively dead
> code, and will be problematic vs. future changes.
>
> Cc: Frank Sorenson <sorenson@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Reviewed-by: Frank Sorenson <sorenson@redhat.com>

>   fs/fat/misc.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index ab28173348fa..37f4afb346af 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -354,9 +354,6 @@ int fat_update_time(struct inode *inode, int flags)
>   			dirty_flags |= I_DIRTY_SYNC;
>   	}
>   
> -	if ((flags & S_VERSION) && inode_maybe_inc_iversion(inode, false))
> -		dirty_flags |= I_DIRTY_SYNC;
> -
>   	__mark_inode_dirty(inode, dirty_flags);
>   	return 0;
>   }
>
