Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300D4681D80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 22:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjA3V4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 16:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjA3V4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:56:08 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07E549560
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 13:56:02 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id h18so2982080ilj.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 13:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nm3u5EMP73yMHbo/gEeitsjZe3xcR1rioTdGrQDcOcw=;
        b=oQ0WTXk7Hm53c6o6Tthdbvt3hBywW1tg2wHnWLBm2Q41trM6Qgpe77wrzs+aHjG4PI
         mr+yswYaA4NYtyeBMSrTTWdoVulg/Qwh+LcrVaYFvkFDEi/3TWlTLzM8LBIIOgZKoR3j
         64NdlPpQa1Ywl4HU3uH5yJfAoww0Gfl7tdmLLCi65UamJQ8nK6ExWSPxjsTMetimmR9K
         0lCTIG5mI2pUNcI0tdj3TbG8741OjqOzcRw/juSMl35CgwjW8Uc1gIF+8G66z2rcxBYE
         mzPhDooq7Yxuzj7tQ5h5hAotg8RfvxkewfZ2SmKnsrNbfmX3npV7dp/1+zbK2BDxVW1c
         xlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm3u5EMP73yMHbo/gEeitsjZe3xcR1rioTdGrQDcOcw=;
        b=HJTk1AC/5Ks5zub9uweXRNiC1ZFHmrZ800bi9eXrmvRwuqRfeTIvE4M/xjpCfU1MpF
         rC0djNCIDe+uHpX0glHopY33h7BUwGI8LaVrLRVibzK1I8Gsk+Rt9BubEoTv7oHL4S08
         RJghka2QloRGn34X4yEjspV1pCxJ+eibkAFDwfrjzPuU5HkV8sG5mQ9Sm0ruCcinwDl8
         cDED2K9HeoZwjHU310lYGoWsKMQW4HHml1erBndKbe0VN/CwqNYrIaucKLOzdHDMonJ3
         84N0WlVunPeRDwwQMEGBeICA+IMwNXxrS0MlHoMR2fGE6LGmjMuK/HZAMAIIB0Hdo7gt
         c4gQ==
X-Gm-Message-State: AFqh2kp96Aed0Jpk/eK882oF9o2Lz3vLdhbawdZ6098aIeYh+TvcrlLd
        sppxSRzJfE2DMTJHprpF73aSHQ==
X-Google-Smtp-Source: AMrXdXvs+Z5KKUYemRLBxMaL4Garqnh0caexG/4IfIup1dJM6E2Qlk5jsvOCXEoH+J8JVyrOgsARUA==
X-Received: by 2002:a92:2a07:0:b0:30c:1dda:42dd with SMTP id r7-20020a922a07000000b0030c1dda42ddmr7440724ile.1.1675115762047;
        Mon, 30 Jan 2023 13:56:02 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s6-20020a02c506000000b003a0e665ad11sm5185712jam.13.2023.01.30.13.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 13:56:01 -0800 (PST)
Message-ID: <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
Date:   Mon, 30 Jan 2023 14:55:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
In-Reply-To: <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/30/23 2:33 PM, Jens Axboe wrote:
> On 1/30/23 4:14 AM, David Howells wrote:
>> Hi Jens,
>>
>> Could you consider pulling this patchset into the block tree?  I think that
>> Al's fears wrt to pinned pages being removed from page tables causing deadlock
>> have been answered.  Granted, there is still the issue of how to handle
>> vmsplice and a bunch of other places to fix, not least skbuff handling.
>>
>> I also have patches to fix cifs in a separate branch that I would also like to
>> push in this merge window - and that requires the first two patches from this
>> series also, so would it be possible for you to merge at least those two
>> rather than manually applying them?
> 
> I've pulled this into a separate branch, but based on the block branch,
> for-6.3/iov-extract. It's added to for-next as well.

This does cause about a 2.7% regression for me, using O_DIRECT on a raw
block device. Looking at a perf diff, here's the top:

               +2.71%  [kernel.vmlinux]  [k] mod_node_page_state
               +2.22%  [kernel.vmlinux]  [k] iov_iter_extract_pages

and these two are gone:

     2.14%             [kernel.vmlinux]  [k] __iov_iter_get_pages_alloc
     1.53%             [kernel.vmlinux]  [k] iov_iter_get_pages

rest is mostly in the noise, but mod_node_page_state() sticks out like
a sore thumb. They seem to be caused by the node stat accounting done
in gup.c for FOLL_PIN.

Hmm?

-- 
Jens Axboe


