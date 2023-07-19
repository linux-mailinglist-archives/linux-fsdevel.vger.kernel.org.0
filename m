Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA72759681
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 15:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGSNWE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjGSNWD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:22:03 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3152198D;
        Wed, 19 Jul 2023 06:21:59 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-563439ea4a2so4328374eaf.0;
        Wed, 19 Jul 2023 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689772919; x=1692364919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LAogQDZBcHGrOfG5j6duNU4yc176bohNY0hykTooUKA=;
        b=ENCh8vrXw3spupql2FpC50tXIdQAseraHYsc6hqKpGvTAQbnWZUgUiJRMQKDJt/XiA
         yNrOgIwgFLGj19gJbhTNVnyy+6CZG5oEsRHnVXadkqyVUaTYh5LEY7T+5KvXWwc4vSk3
         KM4C5vOlucZe5P1LdMsipHNCeIJKwthntPb+L9tRhd9ajKg1LblefwwilD8/Ag9XLuS9
         M9fO11SVQRFFUxOEweV0/2Nxa8i0CDFkhagGmnWoBENegomuUf8orIq5V8nSTIJ4nqJ5
         V0iUnGLh4xJlgl4koR0Dqhe04jGK+lt4l8t27dFhx3NTy44rf6qdONPW/GfiNph/SXg3
         ESLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689772919; x=1692364919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAogQDZBcHGrOfG5j6duNU4yc176bohNY0hykTooUKA=;
        b=lS8GUBhXUDDbMTvzHBm8fXY7//QSHbEZd3gVUmMdc/xvlLk6qNqvYnYWnwsDoh0tKr
         xVjPxfVA0ZYVpk368nS/MaglkPVlZqFPq6LlVYfpgx+5nyuI8qHLKBC6IDxe2ptON17w
         aEacS6L4YWjEhOolriNwFsAtK/dJ4bcBD40/hSoSZnORTOt/67r7mDEBUcrNc2Z3PC1J
         94/QZjV+Yp/WjRGG9XXX1S0w4ulqUJ1Gxj154DZ7AzXiaGXSnvLV/VnnzBpIoQ9s8ByI
         +5hWFGPhP33i103EraAij1qbMfhZa8MGoooRmJBoeZgkv+VmNIH9/pYrIzXV0TQZ1D6N
         wD7Q==
X-Gm-Message-State: ABy/qLbWJ4GYBK0tFBW+cigmWIfZWduE8mynWD8ZfvojXB2+/tOb9+2H
        cZAJFJaU31MDQq+ccwZ7tVg=
X-Google-Smtp-Source: APBJJlHapUq97YBAuGDSH4ZIxslz1sV7eJCPGZO2LG4drvdhQ7G2BamhvmspmJcMjzjxf2pjN2tNLA==
X-Received: by 2002:a05:6358:7e83:b0:134:ccde:596b with SMTP id o3-20020a0563587e8300b00134ccde596bmr15987545rwn.12.1689772918966;
        Wed, 19 Jul 2023 06:21:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n6-20020a0dfd06000000b00561e7639ee8sm1007169ywf.57.2023.07.19.06.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:21:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <221b9a4a-275f-80a4-bba6-fb13a3beec0a@roeck-us.net>
Date:   Wed, 19 Jul 2023 06:21:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] fs: export emergency_sync
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Bill O'Donnell <billodo@redhat.com>,
        Rob Barnes <robbarnes@google.com>, bleung@chromium.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
 <ZLcOcr6N+Ty59rBD@redhat.com>
 <ad539fad-999b-46cd-9372-a196469b4631@roeck-us.net>
 <20230719-zwinkert-raddampfer-6f11fdc0cf8f@brauner>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230719-zwinkert-raddampfer-6f11fdc0cf8f@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/18/23 22:53, Christian Brauner wrote:
> On Tue, Jul 18, 2023 at 09:08:06PM -0700, Guenter Roeck wrote:
>> On Tue, Jul 18, 2023 at 05:13:06PM -0500, Bill O'Donnell wrote:
>>> On Tue, Jul 18, 2023 at 09:45:40PM +0000, Rob Barnes wrote:
>>>> emergency_sync forces a filesystem sync in emergency situations.
>>>> Export this function so it can be used by modules.
>>>>
>>>> Signed-off-by: Rob Barnes <robbarnes@google.com>
>>>
>>> Example of an emergency situation?
>>
>> An example from existing code in
>> drivers/firmware/arm_scmi/scmi_power_control.c:
>>
>> static inline void
>> scmi_request_forceful_transition(struct scmi_syspower_conf *sc)
>> {
>>          dev_dbg(sc->dev, "Serving forceful request:%d\n",
>>                  sc->required_transition);
>>
>> #ifndef MODULE
>>          emergency_sync();
>> #endif
>>
>> Arguably emergency_sync() should also be called if the file is built
>> as module.
>>
>> Either case, I think it would make sense to add an example to the commit
>> description.
> 
> On vacation until next. Please add a proper rationale why and who this
> export is needed by in the commit message. As right now it looks like
> someone thought it would be good to have which is not enough for
> something to become an export.


No, this is just wrong. Did you read Rob's response ? I just pointed out
that there is another user.

Guenter

