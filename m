Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3D0526F37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 09:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiENC5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 22:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiENCzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 22:55:49 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F229C31569C;
        Fri, 13 May 2022 19:21:58 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so9354320pjq.2;
        Fri, 13 May 2022 19:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BEK2GyJXSGgwCpo0TYeuD2ysTVshh6GGsRLe/H8ljtA=;
        b=2S5PddaOM+azrElnathgcdckWrNyFFGLIrrj3z+aqHNcxpfsrIuwZAzpUXKVE5zRed
         GQxzXtkrn68U2oFC6pZoB4zXqBlze7FoVfdouR2UBT4t87VW5pMbP+sNxnR9mcE3aMW5
         Q3SVjPHNS8Wew9NVTEFj5mNzwZcTE7KnXCvvHsC9rEZX50D63Y1/UavHm7zHUykZqxi+
         wHwyoYtX7qtxr0cOPKs5PLipVMG5adXfV+C2rnNffNEO4R0jCjfTfj6BpCElsdTt5Hlx
         mJbn/endKZzA3HFilYFdmhMhMJmdevBDFe8dNYyImg/ByMjdZ+MuoGC19nbsbhGNYKyn
         Kr+A==
X-Gm-Message-State: AOAM530CDCN9aGFD8qZL++dwX+6PxKtLuy7I2GIjd/E5aMgWnReELycv
        54r8vJwikgWEPVNo2miW4dg=
X-Google-Smtp-Source: ABdhPJwwOBsV80Nno76sWLJXXmOyKh2EJn9Vf+gCeWirOJtkWJSzfSrpXv1oWOHm8YCxqtIavTNbsw==
X-Received: by 2002:a17:90b:1b47:b0:1dc:3c0a:dde3 with SMTP id nv7-20020a17090b1b4700b001dc3c0adde3mr7787881pjb.52.1652494918259;
        Fri, 13 May 2022 19:21:58 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id u12-20020a62d44c000000b0050dc7628159sm2399176pfl.51.2022.05.13.19.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 19:21:57 -0700 (PDT)
Message-ID: <88a9baff-5654-b5ce-f7ca-a74a832e359a@acm.org>
Date:   Fri, 13 May 2022 19:21:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/4] workflows/Kconfig: be consistent when enabling
 fstests or blktests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     patches@lists.linux.dev, amir73il@gmail.com, pankydev8@gmail.com,
        tytso@mit.edu, josef@toxicpanda.com, jmeneghi@redhat.com,
        jake@lwn.net
References: <20220513193831.4136212-1-mcgrof@kernel.org>
 <20220513193831.4136212-2-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220513193831.4136212-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/13/22 12:38, Luis Chamberlain wrote:
> We have two kconfig variables which we use to be able to express
> when we are going to enable fstests or blktests, either as a dedicated
> set of tests or when we want to enable testing both fstests and blktests
> in one system. But right now we only select this kconfig variable when
> we are using a dedicated system. This is not an issue as the kconfig
> is a kconfig symbols are bools which are set default to y if either
> the test is dedicated or not.
> 
> But to be pedantic, and clear, let's make sure the tests select the
> respective kconfig for each case as we'd expect to see it. Otherwise
> this can confuse folks reading this.

Is this patch perhaps intended for the kdevops project? If so, please 
add a prefix to make this clear (git format-patch --subject-prefix) when 
sending kdevops patches to Linux kernel mailing lists.

Thanks,

Bart.
