Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCEF4CDE66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 21:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiCDUOE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 15:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiCDUMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:12:41 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10EC25EA0
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 12:05:20 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id o7-20020a056820040700b003205d5eae6eso10133244oou.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Mar 2022 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cD1ZoJibPx8a6ZYW0ir6GwlMwbk0v99dWXm7GlqXJtc=;
        b=yzTBVOHnh2/lw1WEi4Ftyjn9MmKcO9GR999iIl8QDIZ8f473bfhyN+JaqsqzCf6i8+
         KfnqV8aXwP3PhTehm3xjxJL0WmXoo80zbuwPhuaD00i9czLxTl8fFoQmI6ceYGlJB3JU
         uuI51gvQCE0Q916NvdJ4VvdTe8ukIxYdkEG2gUrn7dr94mWE+WPc6+k6Xiz64DyxZFyQ
         20ui0jlVJi8XEJpnblrxChpqSRsV9XHvbxv8F7PpND2WsXtGXeL4CJtb4oszPVY8TSaR
         4nJdXt7Q1nL3y0Iy+yZTxfMtychsLFmirQVMdDLaNAuJMadAednHVU0vTGCUWqK2H2BX
         NMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cD1ZoJibPx8a6ZYW0ir6GwlMwbk0v99dWXm7GlqXJtc=;
        b=CO6vSqnD3MDhAhAMcdjc+ZRyagOcvAuyxrm+7dh1OLtM4rHPe7GNNrZAiuOygVTDg2
         oSJfa1EpUIuEmxGuX149hSBkSI2XGBn/GZwwELinp6h3zfImOFH7lUPHem/vzXOw96B8
         Wi8trUYD2TBQMAW4iQjfXFfzn0q5f+3i4ygwYoPjWXY75q/tVTUVzoX0yut4fiIX5N1g
         UdsdafB3gDbdgNpMzAXEUoxUTLho63hQ6ky/ajEgtDAOZ4Xx3XWHWVvXIZZ79yRKX46W
         gwpPmxnkjJ5ofE666XG4uzKNn62YEHtqg/Sfc7t4KHuOmTnTEgaXZxXL8fs/3eTme4RI
         DfLA==
X-Gm-Message-State: AOAM5314yTmbvhwsOmtFZncHj13Qe+lSNkM9BtvRsSkE7agnvszn+oos
        9FV8vZl0SA34sxye3Ryi28/2W2TKJ+HvsQ==
X-Google-Smtp-Source: ABdhPJxaPNpPdHGtkzBqxR/AbybSNjglxB1qWnG9jsxe0tCA2gjxU9n2s98hohxcBA0drNnu+IBOcw==
X-Received: by 2002:a17:90b:3802:b0:1be:f687:7875 with SMTP id mq2-20020a17090b380200b001bef6877875mr161792pjb.109.1646421866217;
        Fri, 04 Mar 2022 11:24:26 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q9-20020a056a00088900b004e03b051040sm6813168pfj.112.2022.03.04.11.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 11:24:25 -0800 (PST)
Message-ID: <62cc1a9e-6259-d409-1bcb-11c760b0c691@kernel.dk>
Date:   Fri, 4 Mar 2022 12:24:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220304175556.407719-2-hch@lst.de>
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

On 3/4/22 10:55 AM, Christoph Hellwig wrote:
> With the NVMe support for this gone, there are no consumers of these hints
> left, so remove them.

Looks good to me, didn't find any missed spots.

-- 
Jens Axboe

