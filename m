Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5780A51255A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 00:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiD0Wjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 18:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiD0WjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:39:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26462CCBA
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 15:35:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q185so4479452ljb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 15:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zxjODgdLfXb5bMGzaUtB+izM+jyIRFXXBicqRczakdE=;
        b=kOgHkvcXiKDHcf0FPKISXEY5HqGfG/C3VTxC3r+qCyDNb58YQ2Ffm1EN+ZlnNbcklN
         3xuHlw7dI5IAdFE/+iGt8WZvjfO7q6k8VKBoPN743YhsElb89sF9gZKHOWTWzA2c3Rwd
         54YF4aIVaLRZWzwG0KTZKcgCLNVNHLGg3rCWfTKevXQPCDYDJ2IZuZKHtRmaqsYwSR5p
         XpJhcPiWYNEZefwnTjp4pe/ygtOPWtd5Talc9/MypxxDHY+1wSUIaXiRzkx85TXRbhgt
         S+SnpKe5BVSbjw/sLPVHQ/cE9dacC5fnJ8dVd88zXJ4RowaAf8I5IZSkR41CoM++9DjB
         nvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zxjODgdLfXb5bMGzaUtB+izM+jyIRFXXBicqRczakdE=;
        b=ge4JaB75o8WIUH2KCJyFaitHUGtrE19wk52GpMCaAy7qZDkKeyJLHacolRszobhHi/
         ufoiuASo4d+FMfoBHTfeyeqLrcmsO/vN0XepOLZYtXiKMLfl+dCovsc9Y8Udn2XKz+R0
         AXu2epBA/5j3ahfNvRIR9QOGedtbMg0oHBTNWxTP8mmHNsB8NPWqGGibn8RaFP2AunKE
         qILhdnmeLKeixUKs00FXAcO8gd9iq0quE+crTKtnxpUg2DetFvVbb/zcsPHEXQGMH2Pt
         YBND9wea81tkE4Q7WnT9vXHBEdBrNBIlFM+Jq4LrfrWWHyoOI39+eRhwlD+TLhTrDDzc
         Bbyg==
X-Gm-Message-State: AOAM5337/+V1PK2oYBWSg8ND4qVaPt5c7J2CtIIn8cjaC4ho5BnDObIE
        gbYeteHFae3ugod6MUlwojqQig==
X-Google-Smtp-Source: ABdhPJxTIRQmVTxGXf9Qi7GP7rRR0+iZpZJAWqZv6M4gFYfPHkUDB+SbCZAFITpdjJXyLHa2cnkymA==
X-Received: by 2002:a05:651c:1542:b0:249:5d86:3164 with SMTP id y2-20020a05651c154200b002495d863164mr20114887ljp.500.1651098956152;
        Wed, 27 Apr 2022 15:35:56 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id f1-20020a056512322100b00472285d5a74sm362884lfe.147.2022.04.27.15.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 15:35:55 -0700 (PDT)
Message-ID: <53613f02-75f2-0546-d84c-a5ed989327b6@openvz.org>
Date:   Thu, 28 Apr 2022 01:35:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] memcg: accounting for objects allocated for new netdevice
Content-Language: en-US
To:     Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
 <CALvZod6Dz7iw=gyiQ2pDVe2RJxF-7PbVoptwFZCw=sWtxpBBGQ@mail.gmail.com>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <CALvZod6Dz7iw=gyiQ2pDVe2RJxF-7PbVoptwFZCw=sWtxpBBGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/22 19:52, Shakeel Butt wrote:
> On Wed, Apr 27, 2022 at 7:01 AM Michal Koutný <mkoutny@suse.com> wrote:
>>
>> Hello Vasily.
>>
>> On Wed, Apr 27, 2022 at 01:37:50PM +0300, Vasily Averin <vvs@openvz.org> wrote:
>>> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
>>> index cfa79715fc1a..2881aeeaa880 100644
>>> --- a/fs/kernfs/mount.c
>>> +++ b/fs/kernfs/mount.c
>>> @@ -391,7 +391,7 @@ void __init kernfs_init(void)
>>>  {
>>>       kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
>>>                                             sizeof(struct kernfs_node),
>>> -                                           0, SLAB_PANIC, NULL);
>>> +                                           0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
>>
>> kernfs accounting you say?
>> kernfs backs up also cgroups, so the parent-child accounting comes to my
>> mind.
>> See the temporary switch to parent memcg in mem_cgroup_css_alloc().
>>
>> (I mean this makes some sense but I'd suggest unlumping the kernfs into
>> a separate path for possible discussion and its not-only-netdevice
>> effects.)
> 
> I agree with Michal that kernfs accounting should be its own patch.
> Internally at Google, we actually have enabled the memcg accounting of
> kernfs nodes. We have workloads which create 100s of subcontainers and
> without memcg accounting of kernfs we see high system overhead.

I had this idea (i.e. move kernfs accounting into separate patch) too, 
but finally decided to include it into current patch.

Kernfs accounting is critical for described scenario. Without it typical
netdevice creating will charge only ~50% of allocated memory, and the rest
of patch does not allow to protect the host properly.

Now I'm going to follow your recommendation and split the patch.

Thank you,
	Vasily Averin
