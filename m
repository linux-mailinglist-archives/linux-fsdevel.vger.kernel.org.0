Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE21681D89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 22:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjA3V5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 16:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjA3V5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:57:08 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5693D926
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 13:57:07 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id b4so3374709ioj.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 13:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zM1FAPN4aVgv0PsNwh2Z6SiEmu+VWU974/d4fqRl+L4=;
        b=cmbI+LjEdovrcfZ4O1yo+gizi6OKfj93sPfiIfwj4ga1EwlBOLUO0wsGKXP5qSit0Y
         Oh7msuM7dEWAwQyADtiJ70s4K2d7pTcrWG3+yMWc/m+n++dGUQevrjaOoCoSvuVz54UB
         evfCDwN4DlQOrx0MfeXqiWTH7pSppx+Y+6pVxsdWM00TqiAfypFtyDZnoM8/+Yw4bTkq
         7IcYWk8uSaeIqj94xXqr8puaAdRZuWW6ZWnaqRrYM5UBvzv17MMCZDlAV9Uw0WghH5Gx
         pPWCawpU9Ct8m+Z/REB4HcHNv4FNNOZTBmaZdyn2GdN42cgaZ/7NyP/fpGBcm0nqU7KD
         RXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zM1FAPN4aVgv0PsNwh2Z6SiEmu+VWU974/d4fqRl+L4=;
        b=zEZFbnKjvmezjQqFDpGVAnOEFvkeoaPChFaXsU0HhmN9CMSpU6c5UKk+pEAuzvtfoa
         QGaN9Qoyj9/rdkyNTnEjA/dqd2q3jnHRXh0htOUVK/VbbeT5mJo2IxfyqQu8g+w/zZTp
         wRhqN5XQJIZzec4dogEQFMkFlgJBRmqUQ6HXwyVHeJe0BzZyhV46vgzG5zq83jHBm9xy
         5svdP/BQvor1DmoPlum/fNLuUFo5MoTeOh3uZYGiaDAtd9WSVAod1r0S5EW3KopPvQ8+
         dP9QRAGVVWLDaKX5NCdevaNdl1IJVvZC1u1bUFT5dXIZ+EvU4Vq9sq84MKWKdMSA8jIp
         a9qw==
X-Gm-Message-State: AO0yUKUqeBW1a3ufegf74HU3/ojzvaF971iTi4ZqxHNwL5dPKlSjuOs4
        kgZDZe9m8yzKG3oVxG7NCzYoiQ==
X-Google-Smtp-Source: AK7set99KniAMbHUWWBpzRRRsc73wD+V6XoR2N5DlGbxFcMtJ50G+uGAY70+qpAis+xzPW+Vg5ZAbQ==
X-Received: by 2002:a05:6602:88f:b0:719:6a2:99d8 with SMTP id f15-20020a056602088f00b0071906a299d8mr1372843ioz.0.1675115826654;
        Mon, 30 Jan 2023 13:57:06 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w69-20020a025d48000000b00375a885f908sm5004931jaa.36.2023.01.30.13.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 13:57:06 -0800 (PST)
Message-ID: <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
Date:   Mon, 30 Jan 2023 14:57:04 -0700
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
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
In-Reply-To: <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
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

On 1/30/23 2:55 PM, Jens Axboe wrote:
> On 1/30/23 2:33 PM, Jens Axboe wrote:
>> On 1/30/23 4:14 AM, David Howells wrote:
>>> Hi Jens,
>>>
>>> Could you consider pulling this patchset into the block tree?  I think that
>>> Al's fears wrt to pinned pages being removed from page tables causing deadlock
>>> have been answered.  Granted, there is still the issue of how to handle
>>> vmsplice and a bunch of other places to fix, not least skbuff handling.
>>>
>>> I also have patches to fix cifs in a separate branch that I would also like to
>>> push in this merge window - and that requires the first two patches from this
>>> series also, so would it be possible for you to merge at least those two
>>> rather than manually applying them?
>>
>> I've pulled this into a separate branch, but based on the block branch,
>> for-6.3/iov-extract. It's added to for-next as well.
> 
> This does cause about a 2.7% regression for me, using O_DIRECT on a raw
> block device. Looking at a perf diff, here's the top:
> 
>                +2.71%  [kernel.vmlinux]  [k] mod_node_page_state
>                +2.22%  [kernel.vmlinux]  [k] iov_iter_extract_pages
> 
> and these two are gone:
> 
>      2.14%             [kernel.vmlinux]  [k] __iov_iter_get_pages_alloc
>      1.53%             [kernel.vmlinux]  [k] iov_iter_get_pages
> 
> rest is mostly in the noise, but mod_node_page_state() sticks out like
> a sore thumb. They seem to be caused by the node stat accounting done
> in gup.c for FOLL_PIN.

Confirmed just disabling the node_stat bits in mm/gup.c and now the
performance is back to the same levels as before.

An almost 3% regression is a bit hard to swallow...

-- 
Jens Axboe


