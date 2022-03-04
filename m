Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D66B4CDE7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 21:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiCDUQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 15:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiCDUQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:16:38 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1F327403C
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 12:12:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id p8so8483004pfh.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Mar 2022 12:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LeProy8izTno1wkWKHkWuLWt5O2FYK3xOmB4Mvc3iFk=;
        b=4sRPfiYpeKlkerSVQ2gBXlQ7rspcFwPmF/tIH9oXKImY3M7j6/0vu+EzhCplFbZNe/
         gCGjToArVZWQMdXwTbLXTRJz5jiG7YIg17ks+HDdLmhMXqzWD2+GFQycgjOJ9aVotwvR
         9CYfJEKdt+XGQLpWRCYv+0bzWJWGpx07RzbBF8JsK+lprONQ7JWCBPzLsQ4ZkGfYl/p5
         Y7obbGIkT/ltHimuxLpwdzH5nE9Bjd4wjj2Rt1jEo/ZWYb73qNNWU8GkEwoOup/JZh3m
         05GZyHmMJMDHTdAPleMUGDKK9MitOyXF9R0KpApLCtl/F9ctjcvqSStUObEXrip7YF0L
         gkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LeProy8izTno1wkWKHkWuLWt5O2FYK3xOmB4Mvc3iFk=;
        b=nslFFi0hcYJxoe0M6NBnIHWowZmLQ/K3uYhs4cdUNRE64pkI+Bd/8eJ/hbLxRwUnQy
         ERPjjmxi47UUvdEaIu/VNO/1vcFKb35ScM8wa1l6Z9Cn9kVenXGa3sULU7GTta4a59Vh
         AlphKOZkUNjyNvBvyp+9qgkQSAHlOhtFw+i7u4kp4a1/+4mWtW0CzM16KgxScT8oS56g
         ZhSpVFNJH+j9wiJIBgs5gTZ2yas7uYZTjeh7kACqiFnLL+6hgF5lyX28ZVkhzbAG8wTj
         j9ivDN1o8HgsPzpyO3YbiOhfNqIWwsAOjK633hzuByd8Jg2J0xO73StfNbnb1NvODDUy
         AKxA==
X-Gm-Message-State: AOAM5312w1SLlGp1OS/u5wVvBFrbI/XN6LScaFRupxJ/jJK5IF2kL9vv
        KUk0jsMvz8zgVh0T141Ea7Mo25kmLQVroA==
X-Google-Smtp-Source: ABdhPJzdC0Wzazqv5+3vyps6GODMy9xRLdDK4eSu1NPgcSZAabY2LxK6kKGr9BkLQlzdDCqQzUcyIg==
X-Received: by 2002:a63:5c0f:0:b0:374:4a37:48f9 with SMTP id q15-20020a635c0f000000b003744a3748f9mr14228pgb.470.1646422686812;
        Fri, 04 Mar 2022 11:38:06 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t11-20020a056a00138b00b004f1343f915dsm6902723pfg.33.2022.03.04.11.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 11:38:06 -0800 (PST)
Message-ID: <e04da66f-3f72-5d8a-479b-f413222c3646@kernel.dk>
Date:   Fri, 4 Mar 2022 12:38:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] nvme: remove support or stream based temperature hint
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     sagi@grimberg.me, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
References: <20220304175556.407719-1-hch@lst.de>
 <20220304193439.GA3256926@dhcp-10-100-145-180.wdc.com>
 <20220304193600.GA15474@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220304193600.GA15474@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/4/22 12:36 PM, Christoph Hellwig wrote:
> On Fri, Mar 04, 2022 at 11:34:39AM -0800, Keith Busch wrote:
>> On Fri, Mar 04, 2022 at 06:55:55PM +0100, Christoph Hellwig wrote:
>>> -	ctrl->nssa = le16_to_cpu(s.nssa);
>>> -	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
>>> -		dev_info(ctrl->device, "too few streams (%u) available\n",
>>> -					ctrl->nssa);
>>> -		goto out_disable_stream;
>>> -	}
>>
>> Just fyi, looks like the patch was built against an older version of the
>> driver, so it doesn't apply cleanly to nvme-5.18 at the above part.
>>
>> Also please consider folding the following in this patch since it removes all
>> nr_streams use:
> 
> This was against Jens' for-5.18/block tree.  I'm a bit lost what tree
> to best send it against as there will always be some conflicts.

It's always a bit of a problem when patches touch both drivers and core.
I actually put this one in a special branch just because of that. I'll
fold in Keith's incremental.

-- 
Jens Axboe

