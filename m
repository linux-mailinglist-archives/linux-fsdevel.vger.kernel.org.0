Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2279764983D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 04:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiLLDaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 22:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiLLDaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 22:30:00 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B9DE90;
        Sun, 11 Dec 2022 19:29:59 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 17so3293233pll.0;
        Sun, 11 Dec 2022 19:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFgrDYhwuet6qjJ8Wq4sAS0uEiwAbXa5YALkWoY0Wck=;
        b=CfI2c265dZResWya/YCRxbZJeNm+wWXrt3ejL/JdVZYrEs3uGVmhCIt7wFam1u9ZDv
         TqIM/NZGil4Lc0+wUaN1EaWIB8IALKqgAM/xEQa/VvXmnUaOiSq8BQipxwsBd6wOHmv2
         /Tff/l5/3FUSFndWolsvOjWYHP/diJOCjc4YHGl+CRYWNY0V+EB51SDl3n+2KW3y8kM9
         bF1tRJYUgmbHkmUpXdMWW2wWGyME1zN1/wDOoTTkhgMA4A+dNVkVn1PzdkxgAsrE9x0V
         3I6nQa8ucXXTn3dPby/kSsF2QI0j36gxmcYVWIJ1yGIxAiZPbmY9wxt0q9XYglaWTFfJ
         jILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFgrDYhwuet6qjJ8Wq4sAS0uEiwAbXa5YALkWoY0Wck=;
        b=NRsmI2vk3DpPMLBxw/U2qRHmjIRE/3xvNA04vKDoiYezpPLrWAkuxixciFGtAX//CO
         iU2SAQCTQvH9i/R9552HysZLRVpppIqYx5QSigzAtiTaUpB4I98lET02Tn/1juD1tbao
         gfw2BNAUll/UJ+940oe9UVeb+Z7vXKEyodyuDrj2Xc9wpinmmomtQETWBba5Wpeq61Es
         N3hc+TC89/FmeybAVzoagyfvhnd/qp8i2F8KOiLCgPLXUCTc6MmGBfuC6kdb8elcShm0
         Zg/95VqDnAo3PpXkXRtq4dmRuWfbmUogBYVzOWrHFcA81XWuanka/mYVmX6zWNwo31OE
         jX0w==
X-Gm-Message-State: ANoB5pkpqD7rx27ZleUQU+g46/GNO6kqo5fkAXZ0JBjlPFtOqObutCiq
        swfSMM2WOVQUXghisV8G40gRJtzd+SAcxQ==
X-Google-Smtp-Source: AA0mqf6i9aWHyuq++jCdiWIG4ie0EpsS5rt1pb/Uk2cp1zdc+tfPqJhU6zQ63b/iE3WwxK80JCobOg==
X-Received: by 2002:a17:90a:c304:b0:20d:bd63:830a with SMTP id g4-20020a17090ac30400b0020dbd63830amr14630926pjt.49.1670815799253;
        Sun, 11 Dec 2022 19:29:59 -0800 (PST)
Received: from [172.22.60.4] ([1.242.215.113])
        by smtp.gmail.com with ESMTPSA id gf12-20020a17090ac7cc00b0021904307a53sm4338816pjb.19.2022.12.11.19.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 19:29:58 -0800 (PST)
From:   Sungjong Seo <sjdev.seo@gmail.com>
X-Google-Original-From: Sungjong Seo <sj1557.seo@samsung.com>
Message-ID: <5229bc2c-2191-8e4d-f711-4787f8306226@samsung.com>
Date:   Mon, 12 Dec 2022 12:29:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: sj1557.seo@samsung.com
Subject: Re: [PATCH v1 6/6] exfat: reuse exfat_find_location() to simplify
 exfat_get_dentry_set()
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
References: <PUZPR04MB631628014876FC50CD7EF2A781189@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <PUZPR04MB631628014876FC50CD7EF2A781189@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi. Yuezhang,

On 12/5/22 14:10, Yuezhang.Mo@sony.com wrote:
> In exfat_get_dentry_set(), part of the code is the same as
> exfat_find_location(), reuse exfat_find_location() to simplify
> exfat_get_dentry_set().
> 
> Code refinement, no functional changes.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> ---
>  fs/exfat/dir.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 8121a7e073bc..834c0e634250 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -818,7 +818,7 @@ int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
>  		unsigned int type)
>  {
>  	int ret, i, num_bh;
> -	unsigned int off, byte_offset, clu = 0;
> +	unsigned int off;
>  	sector_t sec;
>  	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>  	struct exfat_dentry *ep;
> @@ -831,27 +831,16 @@ int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
>  		return -EIO;
>  	}
>  
> -	byte_offset = EXFAT_DEN_TO_B(entry);
> -	ret = exfat_walk_fat_chain(sb, p_dir, byte_offset, &clu);
> +	ret = exfat_find_location(sb, p_dir, entry, &sec, &off);
>  	if (ret)
>  		return ret;
>  
>  	memset(es, 0, sizeof(*es));
>  	es->sb = sb;
>  	es->modified = false;
> -
> -	/* byte offset in cluster */
> -	byte_offset = EXFAT_CLU_OFFSET(byte_offset, sbi);
> -
> -	/* byte offset in sector */
> -	off = EXFAT_BLK_OFFSET(byte_offset, sb);
>  	es->start_off = off;
>  	es->bh = es->__bh;
>  
> -	/* sector offset in cluster */
> -	sec = EXFAT_B_TO_BLK(byte_offset, sb);
> -	sec += exfat_cluster_to_sector(sbi, clu);
> -
>  	bh = sb_bread(sb, sec);
>  	if (!bh)
>  		return -EIO;
> @@ -878,6 +867,8 @@ int exfat_get_dentry_set(struct exfat_entry_set_cache *es,
>  	for (i = 1; i < num_bh; i++) {
>  		/* get the next sector */
>  		if (exfat_is_last_sector_in_cluster(sbi, sec)) {
> +			int clu = exfat_sector_to_cluster(sbi, sec);
> +
'clu' should be defined as 'unsigned int'.
 However, as of now, exfat_sector_to_cluster() seems to be unused
function and to return wrong type 'int'. So it should be fixed prior to
this patch.

Could you send  patchset again includes the fix?

>  			if (p_dir->flags == ALLOC_NO_FAT_CHAIN)
>  				clu++;
>  			else if (exfat_get_next_cluster(sb, &clu))
