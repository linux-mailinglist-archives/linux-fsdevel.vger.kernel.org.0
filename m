Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903736CD0B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 05:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjC2DeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 23:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2DeE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:34:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50D26A0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 20:33:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so14829075pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 20:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680060817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+TATKpiI/m1aX5zcJcBfi55zhCtiMGHrjCscJ6PomI=;
        b=FPQnW38S34g0z1Q8kz48ty65k3Dmp9KRwwUAJ3ICuzTupops2Y0vhQPj8dbDjn9vKi
         iNDOhiAeln7aJ65JQ9U+d26Sd1cDXR2jOoVIv26/o1QGpr3sPDd9mqyPHJDEwAioixC5
         CwcTzAdsTGmgzcytp/Ffm4OtWMpm/5vaZ6pzLNr54NaV5gTP4WZzh53gL4DV+sAKRa/v
         mAIfV2Xrma2bNgN1io+rzkRF515BrMN2C/avD8RajwuVyVRePzG7JIUxJk3Q65YqAtHV
         2ZT93IG49MkUilPM+5/nCt1QvDqpj13u+mmZZYF+FqNSUNyZrGr1kHBl3y4CeCS5ZCdW
         hUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680060817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4+TATKpiI/m1aX5zcJcBfi55zhCtiMGHrjCscJ6PomI=;
        b=p3v4pfyMiW9C5jBnatdhwH5ktumOR5qjKo1e7zNzPIjsM5+ivPdy5K2VzBoI2ksFYh
         ZfH1ToWD4LFlDguRyU8L744Rvk+o5993n3lz6H5y7et13BLhTb5XKizWteVsSzZSpGhO
         QmVIzUq9NEzmADJpGtm0gV2/QxzrE0X72bzDzT4+TMcuJRhGaC0U7YyVWSzC3QH7PKiL
         tnldfU2TsHU/LIyW9vi+DPwboquwsDT4vaD4dd+X/5JyO3EedvtAwjmi9bfT9q1Oejni
         JKcl3KX/lFWGBzLTABGaohPBk3baF86lwCRFD7b3QluMjCteEXsF78OTYtJ3DUOrx47R
         32+w==
X-Gm-Message-State: AAQBX9dw7xpG34xrgB2Xldv86C+H6XqGCOlXDNy7LmtmpjNT8acCQPU3
        HQR/+QhwpQyYAc+8sWa7HRuuQA==
X-Google-Smtp-Source: AKy350avfa0gKz4Zd6gsYPNpRBHU5Bq4LY4VQkUnGwedVUVb52Mza3ZZUfXF1Abdzp/MXze4iNGrjw==
X-Received: by 2002:a17:903:743:b0:1a1:cd69:d301 with SMTP id kl3-20020a170903074300b001a1cd69d301mr15834742plb.68.1680060817286;
        Tue, 28 Mar 2023 20:33:37 -0700 (PDT)
Received: from [10.3.144.50] ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id k16-20020a63f010000000b004fbd021bad6sm20505062pgh.38.2023.03.28.20.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 20:33:36 -0700 (PDT)
Message-ID: <a9952336-4648-16be-532a-37fd52d67b27@bytedance.com>
Date:   Wed, 29 Mar 2023 11:33:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Re: [PATCH V4 1/5] cachefiles: introduce object ondemand state
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
References: <20230111052515.53941-2-zhujia.zj@bytedance.com>
 <20230111052515.53941-1-zhujia.zj@bytedance.com>
 <131869.1680011531@warthog.procyon.org.uk>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <131869.1680011531@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,
Thanks for reviewing.

在 2023/3/28 21:52, David Howells 写道:
> Jia Zhu <zhujia.zj@bytedance.com> wrote:
> 
>> +enum cachefiles_object_state {
>> +	CACHEFILES_ONDEMAND_OBJSTATE_close, /* Anonymous fd closed by daemon or initial state */
>> +	CACHEFILES_ONDEMAND_OBJSTATE_open, /* Anonymous fd associated with object is available */
> 
> That looks weird.  Maybe make them all-lowercase?

I'll revise it in next version.
> 
>> @@ -296,6 +302,21 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
>>   extern int cachefiles_ondemand_read(struct cachefiles_object *object,
>>   				    loff_t pos, size_t len);
>>   
>> +#define CACHEFILES_OBJECT_STATE_FUNCS(_state)	\
>> +static inline bool								\
>> +cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
>> +{												\
>> +	return object->state == CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
>> +}												\
>> +												\
>> +static inline void								\
>> +cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
>> +{												\
>> +	object->state = CACHEFILES_ONDEMAND_OBJSTATE_##_state; \
>> +}
>> +
>> +CACHEFILES_OBJECT_STATE_FUNCS(open);
>> +CACHEFILES_OBJECT_STATE_FUNCS(close);
> 
> Or just get rid of the macroisation?  If there are only two states, it doesn't
> save you that much and it means that "make TAGS" won't generate refs for those
> functions and grep won't find them.

Actually there is one more state <reopening> will be introduced in
patch3 and 30+ loc for repeated functions will be added if we drop the 
macro.
Shall I keep using the macro or replace it?
> David
