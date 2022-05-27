Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC41536453
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352032AbiE0Ove (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347466AbiE0Ovc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 10:51:32 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE7B868
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 07:51:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b4so4834109iog.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3NZi0QBQcZD+ui20xRoQ/sb3r111mI2YlANTzmw/9TI=;
        b=t839gYSjb8iEV4edwRVqx9roiCnc6S1erMx5hC1J3KqZe18bMda1HjEaZROuF/nQST
         N1ehnnjYmrETsX6kLvuIOn5dYRnDfOi/J37XcpH6GYwvVIVE266xZgS4bX/0DkF+T1ha
         P/hvr/XmJCD6kSvPYnL60stHWMzv5qe2yafr2qRIqdq5b43rY7EoK5uzes2lS3kE0zib
         EQmJ/ktzpTi6GHyZbY0c8Yk7GVcuVSUSqCFCVBke4efwUi3vcVHKfHOmm9LFJ7ngys0Q
         eR9UWj83AqYV6kIiOPGU7XqD44HxWWlxTK1nLIf1l7xjUWJ6Yy38iYxraVDuJbZ1j0Pk
         umvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3NZi0QBQcZD+ui20xRoQ/sb3r111mI2YlANTzmw/9TI=;
        b=0T5ve7JodSZd+cQ+rfE4fFGl3cay0mZemsEoNS9nw5dSpkDY023AqEjp3Tj6Ea0T/+
         cMsuIV4n2mrGundL5SKyye9G13HULa1D06IN1/Y7s3tKa3C6ZMQEM8HYRBUHuVtVDkYQ
         dsToeW2xe1ubx8S73oagebQjOYmOWZWA1UY/mD17xK5UEhXdCuwfhdnKVC7QxJNUfX7g
         VnnOmcP6LPVBpHv42zeI2VKOHxA/gC4YVrymjLYiOYi8fPmi+upFTrXMaG5R5ed5mCdZ
         fB8ubNfm6/iUP825tsor0UvpgL70x17bQ1Z9UetOlpxqc47kwX1Ytny6VOskDhGhB2Hf
         r8sQ==
X-Gm-Message-State: AOAM530/55DgYQlqwkeK0b14HA9oc815vGldQWMj/xGbSvYAtIJFNbHl
        VOSMbcGJKbDc5bUwsRHh/EJValvoCgTDtA==
X-Google-Smtp-Source: ABdhPJyLxBhQD3wmOJnIPEEBrK2B9XnwkLbYK/f7q8RGizT9De3+l53Hb19gz6+FP9Ydlw2t5K1vXQ==
X-Received: by 2002:a6b:e814:0:b0:660:d496:d2d2 with SMTP id f20-20020a6be814000000b00660d496d2d2mr13277776ioh.147.1653663089495;
        Fri, 27 May 2022 07:51:29 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id cs1-20020a056638470100b0032e394f0453sm604234jab.97.2022.05.27.07.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 07:51:28 -0700 (PDT)
Message-ID: <984adb1d-df9a-8096-379e-4761df357f37@kernel.dk>
Date:   Fri, 27 May 2022 08:51:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <YpAK+CG74k1lc5z4@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YpAK+CG74k1lc5z4@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/26/22 5:19 PM, Al Viro wrote:
> On Sun, May 22, 2022 at 07:04:36PM +0000, Al Viro wrote:
> 
>> copy_page_{from,to}_iter() iovec side is needed not for the sake of
>> optimizations - if you look at the generic variant, you'll see that it's
>> basically "kmap_local_page + copy_{to,from}_iter() for the contents +
>> kunmap_local_page", which obviously relies upon the copy_{to,from}_iter()
>> being non-blocking.  So iovec part of it genuinely needs to differ from
>> the generic variant; it's just that on top of that it had been (badly)
>> microoptimized.  So were iterators, but that got at least somewhat cleaned
>> up a while ago.  And no, turning that into indirect calls ended up with
>> arseloads of overhead, more's the pity...
> 
> Actually, I take that back - the depth of kmap stack won't be increased
> by more than one compared to mainline, so we can switch iovec and ubuf
> variants to generic.
> 
> See #new.iov_iter; I do like the diffstat - -110 lines of code, with new
> flavour added...
> 
> Completely untested, though.

That's nice looking indeed. Not just dropping the code, but reducing the
unwieldly number of branches in there. A bit pressed for time these
days, but I'll try and resurrect some testing mid next week.

-- 
Jens Axboe

