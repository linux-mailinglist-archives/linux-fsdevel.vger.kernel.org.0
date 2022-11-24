Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2663799A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 14:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiKXNCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 08:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiKXNB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:01:56 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D45A467D;
        Thu, 24 Nov 2022 05:01:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 4so1445137pli.0;
        Thu, 24 Nov 2022 05:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvPyI4qF5zofuh1zrNXiSEAno3Z3fjXXC/WYMRPiFOk=;
        b=nYcA6MSNLUlYNiApEdAQ5ok/m2zKIeHlXMUk7HJWFDxLrxXIBvtBgSEq10ZqcWynzL
         QyrlUUlWFe0uUMOFbvOiyHaudq4/w6FIMfSUVia+lM/mUzAxoiRAerJTX8vPUA+RwQu0
         wshp4som4V6SPrRBVlgsr07dC29X/rI6vKu4hPLbScdVRXgLG1zu0CvO4+CP2Tdh6fF5
         XAH2gp3xRv10/41T7I9BhyISFWSB2/Pj43Zh4KKattNpIRDBcUSYY77po0G+8Y6WnWTb
         nam2oDzHat0GsPf8mJ14i8D49FHqcwkI7vFxAwDNVcAOJfB0TeXkVAiXUPEvDs6R5oIx
         3pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvPyI4qF5zofuh1zrNXiSEAno3Z3fjXXC/WYMRPiFOk=;
        b=LK2f3S4QjxVCK40i92hYf215RnraY5F9e/CBsHU3jq7fj3f2NtWWGYNpsRn4eNciZ/
         DaMGis/8KPP64CHuv6DyIMI/GmlvT/tNdgV3DIydCHs7aEooCG3rqlmziDlXSYX0uneN
         JjD5Va3JC9jCb4S85gC85P4aeAm0iqF3qivS8YgIuTNwb6VwvXSpxKMpmlNyuVaght4V
         XBCPdmLzgbGZumBWjbvs3E+cGCqraf7+6Md0K0HA9PbJKHsBSdu9kfL0gqEXeZoKpXFg
         99L2edSU+fvG9+R9TzlUXlcn6u7yGgz4q1G7u3yJbEMDs36QMq5qZFU/VwpSguZzlQSz
         Ro3Q==
X-Gm-Message-State: ANoB5pnE5d6PyAHzR0Qkxvm96SDAcSzuHZFM29ZIIuxQ3fDo3+x2Byd0
        B0vmgXF8oJO1lVhY1N7fpOM=
X-Google-Smtp-Source: AA0mqf5Jv//ltq6QrucPslFfZgCb/C+E0IzZjRrv2h9O1FL6wSkqcQ4dm+Ko2yKffZo2rgY7kVjrcQ==
X-Received: by 2002:a17:902:868b:b0:186:8c19:d472 with SMTP id g11-20020a170902868b00b001868c19d472mr14119346plo.12.1669294899453;
        Thu, 24 Nov 2022 05:01:39 -0800 (PST)
Received: from [172.18.255.73] ([1.242.215.113])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b00178aaf6247bsm1295952plf.21.2022.11.24.05.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 05:01:39 -0800 (PST)
From:   Sungjong Seo <sjdev.seo@gmail.com>
X-Google-Original-From: Sungjong Seo <sj1557.seo@samsung.com>
Message-ID: <45e7ecdd-c4a0-5d41-5e32-db53424558da@samsung.com>
Date:   Thu, 24 Nov 2022 22:01:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: sj1557.seo@samsung.com
Subject: Re: [PATCH v2 0/5] exfat: move exfat_entry_set_cache from heap to
 stack
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
References: <PUZPR04MB631661A405BDD1987B969597810F9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <PUZPR04MB631661A405BDD1987B969597810F9@PUZPR04MB6316.apcprd04.prod.outlook.com>
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

Looks good.
Thanks for your patchset.

Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> This patchset reduces the size of exfat_entry_set_cache and moves
> it from heap to stack.
> 
> Changes for v2:
>   * [1/5] [5/5]
>     - Rename ES_*_ENTRY to ES_IDX_*
>     - Fix ES_IDX_LAST_FILENAME() to return the index of the last
>       filename entry
>     - Add ES_ENTRY_NUM() MACRO
> 
> Yuezhang Mo (5):
>   exfat: reduce the size of exfat_entry_set_cache
>   exfat: support dynamic allocate bh for exfat_entry_set_cache
>   exfat: move exfat_entry_set_cache from heap to stack
>   exfat: rename exfat_free_dentry_set() to exfat_put_dentry_set()
>   exfat: replace magic numbers with Macros
> 
>  fs/exfat/dir.c      | 70 ++++++++++++++++++++++++++-------------------
>  fs/exfat/exfat_fs.h | 37 ++++++++++++++++++------
>  fs/exfat/inode.c    | 13 ++++-----
>  fs/exfat/namei.c    | 11 ++++---
>  4 files changed, 80 insertions(+), 51 deletions(-)
