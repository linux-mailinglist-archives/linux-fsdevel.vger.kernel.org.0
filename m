Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B1D78B7A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 20:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjH1Szd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 14:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjH1SzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:55:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A3194;
        Mon, 28 Aug 2023 11:55:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ff882397ecso5397715e87.3;
        Mon, 28 Aug 2023 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248903; x=1693853703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ny3Ash71jKrYUJQy9eTK7yPDCixzkf5SBSxk2dp7juw=;
        b=hfPdkTStQUiGhYD+gSY9L2W6bRdHh9rGQvkuxMH6hyrs/T6lk8pVgVKCKe859jpYYz
         AN03QKnJf5XMARq0ttNlrbqokqmhWWVOtvERjCsxqij42Kf8N1VPqD/NKld/pzl04wYo
         petumI1QbWSYFH3vuXb99xE46DPhwTiwzoThFbTF0AClOP0jKUwCrS8IeT70XGHhmMEA
         BMhlpkOQe1Mm/+KotljRjqlSyfbQnHKWjPcl9HVZCJMX/2osAZy11i69LWE6PkxV1KUL
         phiSpKGHh9wOJycbA8P46TYbHP8dvbUhdcwaufPdtx3aJXkV/mQOmR85BX2SfvEIFDTn
         L20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248903; x=1693853703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ny3Ash71jKrYUJQy9eTK7yPDCixzkf5SBSxk2dp7juw=;
        b=BIYzH+jb4PSVfdsv2XLOGsccZ1hsW+1l4vNsgsEPKoAMqyvteXZJy7GNkdqYUhDCws
         k8QXFYReCTxkewWkXvNERf1/0uGUzG6YxGBfP1pXaJTv8g6iQPkKdJWTPo9dYbBRuGYn
         TADl7hYKL0Wo037D5ULx4UQtbwGEL3bPDKaj567zQZBlQj26P6T+X59R2cmZrQihGonK
         KmsoqnbQWnxKHOdZYJKBR9m4TADilSiQmBlRmzw/BG6Ykrn1vJIXi0ARAa7CX5QTBEZ/
         YXtVmrIb0ukMFP7xuEOtLWlMVz8kE0t8EdUMJZiveU3gCod04AIMDd8yU2ayQ5/TGWfF
         wVHQ==
X-Gm-Message-State: AOJu0Yzvr/sSwnGgaDLCz7Ih/ruf0VxF90VObM/rU6ix16HI1sYpOY5+
        V88yHOeQWHAv+OzERtdRddTKsWLVU5qBHA==
X-Google-Smtp-Source: AGHT+IFIoaXCbIP7CUJ2lsOmKaulSpx75NEZFOzm0PJ2NUQzcRHhdCzIOPgBs8qB6iLNHZva6D04EA==
X-Received: by 2002:a19:385e:0:b0:4fe:7dcb:8ea5 with SMTP id d30-20020a19385e000000b004fe7dcb8ea5mr17129184lfj.25.1693248902943;
        Mon, 28 Aug 2023 11:55:02 -0700 (PDT)
Received: from [192.168.0.75] (85-160-49-194.reb.o2.cz. [85.160.49.194])
        by smtp.gmail.com with ESMTPSA id q9-20020a170906940900b0099bccb03eadsm4935592ejx.205.2023.08.28.11.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:55:02 -0700 (PDT)
Message-ID: <c2b1cd09-f35e-9281-81a2-75e4d624ae0f@gmail.com>
Date:   Mon, 28 Aug 2023 20:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] exfat: add ioctls for accessing attributes
Content-Language: cs, en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <30bfc906-1d73-01c9-71d0-aa441ac34b96@gmail.com>
 <20230828161251.GA28160@frogsfrogsfrogs>
From:   Jan Cincera <hcincera@gmail.com>
In-Reply-To: <20230828161251.GA28160@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023, Darrick J. Wong wrote:
> On Sun, Aug 27, 2023 at 12:42:07PM +0200, Jan Cincera wrote:
>> Add GET and SET attributes ioctls to enable attribute modification.
>> We already do this in FAT and a few userspace utils made for it would
>> benefit from this also working on exFAT, namely fatattr.
>>
>> Signed-off-by: Jan Cincera <hcincera@gmail.com>
>> ---
>> Changes in v2:
>>   - Removed irrelevant comments.
>>   - Now masking reserved fields.
>>
>>  fs/exfat/exfat_fs.h |  6 +++
>>  fs/exfat/file.c     | 93 +++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 99 insertions(+)
>>
>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>> index 729ada9e26e8..ebe8c4b928f4 100644
>> --- a/fs/exfat/exfat_fs.h
>> +++ b/fs/exfat/exfat_fs.h
>> @@ -149,6 +149,12 @@ enum {
>>  #define DIR_CACHE_SIZE		\
>>  	(DIV_ROUND_UP(EXFAT_DEN_TO_B(ES_MAX_ENTRY_NUM), SECTOR_SIZE) + 1)
>>  
>> +/*
>> + * attribute ioctls, same as their FAT equivalents.
>> + */
>> +#define EXFAT_IOCTL_GET_ATTRIBUTES	_IOR('r', 0x10, __u32)
>> +#define EXFAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u32)
> 
> Can you reuse the definitions from include/uapi/linux/msdos_fs.h instead
> of redefining them here?
> 
> Otherwise this looks like a mostly straight port of the fs/fat/
> versions of these functions.
> 
> --D
> 

I don't think that's necessary right now, as exfat doesn't reuse attribute
definitions either. With some refactoring of existing code we could reuse
both, but I've been trying to keep this patch as simple as possible.

Jan Cincera
