Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E9953B4CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiFBIJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiFBIJE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:09:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CFE4839C
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jun 2022 01:09:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q7so5407247wrg.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jun 2022 01:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eUM9+XnalZT18c7gwsWOLxfN4u2iAez4Y1cABKmJu7Y=;
        b=pEjALHln/V5MI9KV/B8S84wKMxLpaS6mFQYsQg4h1Pw54EPO1vAV8zqlmjOHzeRiKS
         qFAOHOdwesAKJ+PBPUEOiwmIh5shZOixMb6R4W/6Ndz9dtr+CYBytV4gTde4NlQJFuyF
         jtQ76iLIWD/UxnCIq420Md4LDbyHKOpT/r7DDphdjP+JT+B5PFW1yBKTJXu7XqaHcRzR
         rhFrfUic4ClKv1WRcrM3H8g1C61tTdejTt6RQ9oy8R66zL0YE8m5xngYIGRFiHLQb2B9
         QLXUUcfzqAw24VJLu0K7m1AyLCYxCpArGXpmStRDdkq3TSF9bqhcOeiMkHio/qX/MTKu
         JQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eUM9+XnalZT18c7gwsWOLxfN4u2iAez4Y1cABKmJu7Y=;
        b=OH0S4jIhCF82mSMa2lqUpKNTllmCJyfTOsT8VZuoSQCRb/mkU2Y4V1G9Ctn/NYfwOG
         05DZ3oAX1RmhzrXO/WC0wrmET/PUOUgRsk2TR40BftcWfwW0Nn7FOOmLU7C+eg7iirdm
         UCDJzCKajrIzGDM3XGlm2bzRZiVQ+Qt6fKWoL7y+6JUMcyzz+zDHoCyd46gOGq8hZh6I
         6QPUjotQnhOeubTUjjiZqO6cMU8yt1K8ZNiBKtDusuOr0bdZx9P5cvpaHRecJ0673VWe
         pHE3E/K8u200Nb4ooRxtKMxx23Yp+MibU+YKeBvdQhW2RoC4pD1Ft1Ybaa0WZeS/rDaz
         2brg==
X-Gm-Message-State: AOAM533w8ORa8hspwdNnWYV753Y82kHolaNYfyaYugY/4sQvdedyumKL
        ZWCNGjPpGxuvBOkLmqJ8h9dZcA==
X-Google-Smtp-Source: ABdhPJyJQE6sH13ogO1etQC1ENO2og0WoBGaPBG3HKHQ+nyT0I31zdiYkJyuiDyDUMe3DaMxCJwp1A==
X-Received: by 2002:adf:d193:0:b0:210:2e72:48b6 with SMTP id v19-20020adfd193000000b002102e7248b6mr2483115wrc.387.1654157342024;
        Thu, 02 Jun 2022 01:09:02 -0700 (PDT)
Received: from [10.40.36.78] ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id z14-20020adfd0ce000000b0020e68dd2598sm3574188wrh.97.2022.06.02.01.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 01:09:01 -0700 (PDT)
Message-ID: <545ab14b-a95a-de2e-dbc6-f5688b09b47c@kernel.dk>
Date:   Thu, 2 Jun 2022 02:09:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 00/15] io-uring/xfs: support async buffered writes
Content-Language: en-US
To:     Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     david@fromorbit.com, jack@suse.cz, hch@infradead.org
References: <20220601210141.3773402-1-shr@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220601210141.3773402-1-shr@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/1/22 3:01 PM, Stefan Roesch wrote:
> This patch series adds support for async buffered writes when using both
> xfs and io-uring. Currently io-uring only supports buffered writes in the
> slow path, by processing them in the io workers. With this patch series it is
> now possible to support buffered writes in the fast path. To be able to use
> the fast path the required pages must be in the page cache, the required locks
> in xfs can be granted immediately and no additional blocks need to be read
> form disk.

This series looks good to me now, but will need some slight rebasing
since the 5.20 io_uring branch has split up the code a bit. Trivial to
do though, I suspect it'll apply directly if we just change
fs/io_uring.c to io_uring/rw.c instead.

The bigger question is how to stage this, as it's touching a bit of fs,
mm, and io_uring...

-- 
Jens Axboe

