Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D5E777FED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjHJSFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 14:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjHJSFg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:05:36 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61893ED;
        Thu, 10 Aug 2023 11:05:36 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40fda409ca7so7376541cf.3;
        Thu, 10 Aug 2023 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691690735; x=1692295535;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CdwQW66GxTUGS1hb03P56Xx3tOus4NqR8pcDQ0WauvY=;
        b=MJN7kCPaFF4uldJBQTNaOx1rhfR8bZNApbQnxeAnsj4fy+PUcAl5vZd0bkWHaZY2xP
         LB1FStaBMIyPL0x+cGVSExlJsspt014SF1CZQfxav72bQETBAm/uYudkyPrsUjBJRwys
         IjnTGKYvtiiTg2PX/tb9LWOgrH3A6ej3PNv/mu7cuK4n+HwU0AWrzGfYe8P820N7YbaU
         Rf6SQan0K5LDjxyO8iMSwnRGe6OfwgTcZy9TNoC9AYG6UQJZEDHl7Wn0XpsacfGsSrzs
         QF4v38ZYjhIB7bi1deFtgk5pI3gVHLU5zzGf2YD5RxoOvSe5EdwbGt9C6F8oBe+gb1WF
         Vk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691690735; x=1692295535;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdwQW66GxTUGS1hb03P56Xx3tOus4NqR8pcDQ0WauvY=;
        b=OaK1cOjHb0MDSDMIWsVZ1uVXffV9fALbw2U59e2aupQl4B/T/tJz7mRLAstJgqj29W
         JwwJj9dkDL3kOYgL/yY06KRDTk9SKphOj+h6kwY4URGQ2tuH/VbrqtnnvnloyKP/T4MM
         JlLrjKMYGSn+9MFxXeh1+4z1W9PNZ7tH5NZW7RbqRiGuuvmXJyCkztk7UyynEAbtjpOr
         M1UUSjxHOG/DPotjkBd/bK+j37naUsxELMUAlApeZM0of/+znLD7tEhSpgSRaX8rc878
         t0Gph+tqlr1Sa61tk48H17A9Ok6DoOc7TBNuCNIjAp7ZxhuFIGeUEefaQPZmoi8TjaPq
         b0pQ==
X-Gm-Message-State: AOJu0YxYtSZJ7F6MVJui20iXcBJylRg0YwZISusr2J9LhHU8jZidBo9s
        OL1vmTm+gGQFYL9gKGJqPfM=
X-Google-Smtp-Source: AGHT+IHXD6o/DnCp0MyI00jckONxtiHikBtwmkaG5MB3wKcDgd6/RNF8R/4wVAZmJrgCHXejKyxXUQ==
X-Received: by 2002:a05:622a:1711:b0:405:5aed:300a with SMTP id h17-20020a05622a171100b004055aed300amr4307115qtk.19.1691690735418;
        Thu, 10 Aug 2023 11:05:35 -0700 (PDT)
Received: from [172.16.0.69] (c-67-184-72-25.hsd1.il.comcast.net. [67.184.72.25])
        by smtp.gmail.com with ESMTPSA id 1-20020a05620a070100b0076816153dcdsm646174qkc.106.2023.08.10.11.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 11:05:35 -0700 (PDT)
Sender: Frank Sorenson <frank.sorenson@gmail.com>
From:   Frank Sorenson <frank@tuxrocks.com>
X-Google-Original-From: Frank Sorenson <sorenson@redhat.com>
Message-ID: <9646c74c-1402-05fb-4e7f-60d2e7818831@redhat.com>
Date:   Thu, 10 Aug 2023 13:05:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] fat: make fat_update_time get its own timestamp
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230810-ctime-fat-v1-0-327598fd1de8@kernel.org>
 <20230810-ctime-fat-v1-2-327598fd1de8@kernel.org>
In-Reply-To: <20230810-ctime-fat-v1-2-327598fd1de8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> In later patches, we're going to drop the "now" parameter from the
> update_time operation. Fix fat_update_time to fetch its own timestamp.
> It turns out that this is easily done by just passing a NULL timestamp
> pointer to fat_truncate_time.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Reviewed-by:  Frank Sorenson <sorenson@redhat.com>


>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 37f4afb346af..f2304a1054aa 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -347,7 +347,7 @@ int fat_update_time(struct inode *inode, int flags)
>   		return 0;
>   
>   	if (flags & (S_ATIME | S_CTIME | S_MTIME)) {
> -		fat_truncate_time(inode, now, flags);
> +		fat_truncate_time(inode, NULL, flags);
>   		if (inode->i_sb->s_flags & SB_LAZYTIME)
>   			dirty_flags |= I_DIRTY_TIME;
>   		else
>
