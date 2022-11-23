Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E11636094
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 14:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiKWNzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 08:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbiKWNz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:55:27 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22E674CDE;
        Wed, 23 Nov 2022 05:49:55 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id io19so16681649plb.8;
        Wed, 23 Nov 2022 05:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLcFo0lu8cqSfknNhs9/1pJi0QRuj3g0hxJQsndQlGA=;
        b=KHfLPjpV0roQegJX4QvO3Ynva2lRROad+mFpIniveQxffZ9aI3aLoFpbUpcRr6h6JO
         j8HMPT6dKMo8dMpzBhrn4iFct88bpL5bAyy2ZqSoGv0SEeD1zCUD1J+JmgGzqrJP67xL
         tUCIt57AjPMniQsrnfpg+MasYt6sAYDKh8APVhoCnzhlVmAqtX3C8Xrc38Do8ClEZbjX
         poyON2tfOMYGPSRklNHIUiAYxHc4p2wnF/jCM0mv07qfK17Jz5KqlG8SFCzKZWEewCDx
         CJqXpCu0RJrs5Rz4nJauV/OIFsVKk+VE8rKCpwEk7Z6KfkdfbFTdjedsyPj8zJW/1O86
         /znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLcFo0lu8cqSfknNhs9/1pJi0QRuj3g0hxJQsndQlGA=;
        b=Ef7SuKAHFsikMhWS+sGHoZ1fn1B4HuaGCKP0zrVRlm8z21Sn7tWg4A9ivqngGs5+sR
         q6cFwKfzQjF+NVbVotYrnnv17dNrfwJoOqZRxXVEL/wmVaAmUiClwOukaMUfgtU6niDF
         e4IW4cK6Cb1RVvtV19toznYU/1/uaE1Q7R7bopGbQ4ACfjIJbQpvww8BJEpiJJqr0DNc
         CrdjFbn43PV1rQO2u4Y+gmJ92i47eaSuJGEE1Zrq+cB1xpOrkdenDD2DW8xXFfL+k1DY
         5Ecy6xidoSS2c7UZu7AA4QRHmS3pr/7TxWTiqSIFJHHf/XO7LGPJQyXtAnsl+23js9hE
         BnrQ==
X-Gm-Message-State: ANoB5pnDxdLN7jPEkVRzU21ZhDpTTdJ7kK90GMbzsrlW52DSUW9rmkwW
        yZgkq1KlSq9zhncEHCpmgPs=
X-Google-Smtp-Source: AA0mqf5ZrmKgsvp+pzyLxubw5UrD4ayLcud2hb3+Ri6LNiY4I8S9SWhn2NY//Jr/7bHrowlrp+4/Ow==
X-Received: by 2002:a17:90a:70c5:b0:218:985d:25a0 with SMTP id a5-20020a17090a70c500b00218985d25a0mr21576850pjm.168.1669211395444;
        Wed, 23 Nov 2022 05:49:55 -0800 (PST)
Received: from [172.18.246.94] ([1.242.215.113])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001885d15e3c1sm14246884plb.26.2022.11.23.05.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 05:49:55 -0800 (PST)
From:   Sungjong Seo <sjdev.seo@gmail.com>
X-Google-Original-From: Sungjong Seo <sj1557.seo@samsung.com>
Message-ID: <feeacb4c-be40-9090-1926-02cdbb6b3a15@samsung.com>
Date:   Wed, 23 Nov 2022 22:49:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/5] exfat: reduce the size of exfat_entry_set_cache
Reply-To: sj1557.seo@samsung.com
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
References: <PUZPR04MB63168831A4F57B74109A893A81069@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <PUZPR04MB63168831A4F57B74109A893A81069@PUZPR04MB6316.apcprd04.prod.outlook.com>
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

Hi, Yuezhang Mo,

> In normal, there are 19 directory entries at most for a file or
> a directory.
>   - A file directory entry
>   - A stream extension directory entry
>   - 1~17 file name directory entry
> 
> So the directory entries are in 3 sectors at most, it is enough
> for struct exfat_entry_set_cache to pre-allocate 3 bh.
> 
> This commit changes the size of struct exfat_entry_set_cache as:
> 
>                    Before   After
> 32-bit system      88       32    bytes
> 64-bit system      168      48    bytes
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
> ---
>  fs/exfat/exfat_fs.h | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index a8f8eee4937c..7d2493cda5d8 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -9,6 +9,7 @@
>  #include <linux/fs.h>
>  #include <linux/ratelimit.h>
>  #include <linux/nls.h>
> +#include <linux/blkdev.h>
>  
>  #define EXFAT_ROOT_INO		1
>  
> @@ -41,6 +42,14 @@ enum {
>  #define ES_2_ENTRIES		2
>  #define ES_ALL_ENTRIES		0
>  
> +#define ES_FILE_ENTRY		0
> +#define ES_STREAM_ENTRY		1
> +#define ES_FIRST_FILENAME_ENTRY	2

New ES_ definitions seem to be an index in an entry set. However, this
is confusing with definitions for specifying the range used when
obtaining an entry set, such as ES_2_ENTRIES or ES_ALL_ENTRIES.
Therefore, it would be better to use ES_IDX_ instead of ES_ to
distinguish names such as ES_IDX_FILE, ES_IDX_STREAM and so on.
(If you can think of a better prefix, it doesn't have to be ES_IDX_)

> +#define EXFAT_FILENAME_ENTRY_NUM(name_len) \
> +	DIV_ROUND_UP(name_len, EXFAT_FILE_NAME_LEN)
> +#define ES_LAST_FILENAME_ENTRY(name_len)	\
> +	(ES_FIRST_FILENAME_ENTRY + EXFAT_FILENAME_ENTRY_NUM(name_len))
> +
As with the newly defined ES_ value above, it makes sense for the
ES_LAST_FILENAME_ENTRY() MACRO to return the index of the last filename
entry. So let's subtract 1 from the current MACRO.

>  #define DIR_DELETED		0xFFFF0321
>  
>  /* type values */
> @@ -68,9 +77,6 @@ enum {
>  #define MAX_NAME_LENGTH		255 /* max len of file name excluding NULL */
>  #define MAX_VFSNAME_BUF_SIZE	((MAX_NAME_LENGTH + 1) * MAX_CHARSET_SIZE)
>  
> -/* Enough size to hold 256 dentry (even 512 Byte sector) */
> -#define DIR_CACHE_SIZE		(256*sizeof(struct exfat_dentry)/512+1)
> -
>  #define EXFAT_HINT_NONE		-1
>  #define EXFAT_MIN_SUBDIR	2
>  
> @@ -125,6 +131,16 @@ enum {
>  #define BITS_PER_BYTE_MASK	0x7
>  #define IGNORED_BITS_REMAINED(clu, clu_base) ((1 << ((clu) - (clu_base))) - 1)
>  
> +/* 19 entries = 1 file entry + 1 stream entry + 17 filename entries */
> +#define ES_MAX_ENTRY_NUM	ES_LAST_FILENAME_ENTRY(MAX_NAME_LENGTH)

Of course, it needs to add 1 here.

> +
> +/*
> + * 19 entries x 32 bytes/entry = 608 bytes.
> + * The 608 bytes are in 3 sectors at most (even 512 Byte sector).
> + */
> +#define DIR_CACHE_SIZE		\
> +	(DIV_ROUND_UP(EXFAT_DEN_TO_B(ES_MAX_ENTRY_NUM), SECTOR_SIZE) + 1)
> +
>  struct exfat_dentry_namebuf {
>  	char *lfn;
>  	int lfnbuf_len; /* usually MAX_UNINAME_BUF_SIZE */
> @@ -166,11 +182,11 @@ struct exfat_hint {
>  
>  struct exfat_entry_set_cache {
>  	struct super_block *sb;
> -	bool modified;
>  	unsigned int start_off;
>  	int num_bh;
>  	struct buffer_head *bh[DIR_CACHE_SIZE];
>  	unsigned int num_entries;
> +	bool modified;
>  };
>  
>  struct exfat_dir_entry {
