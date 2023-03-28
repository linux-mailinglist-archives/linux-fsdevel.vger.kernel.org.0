Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F225B6CCAA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 21:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjC1TbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC1TbA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:31:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552173582
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:30:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a261eb6821so460285ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 12:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680031859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chnOnEtMLrTfYzot3SaGbzCiGQEAj56MZNFl4JNPiEc=;
        b=DrjW3Pzw9A7q1V7K5toumS4iKxg20nJEpAFiHotAhMLuT5LN2AZc7eg01QuMB3rNoH
         HhaO3p2ydAtb1UFMW/bNvRxGDS4gnBJM68HeNL7uHnDHi/S7wZ8a76VVeubodoJebTBa
         x/LWgZOTgc1M+VGNqlOfgYF+mGPcdBUKdwWSQupJdZpEZfRP8e1mzoDAFMo03gvfGhSN
         2oJnoDP6YgOlIZ5Apog14os/stwShjmZXrjSdf7UNwGKilpeSyrPind8CGwvRvlhIPaK
         /p0dzGubtBStRJCxZWTqtqQM94Xb1QrqfYjuFmPFanUBIUmf6jL9bagDHHRiXJZADENr
         LfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chnOnEtMLrTfYzot3SaGbzCiGQEAj56MZNFl4JNPiEc=;
        b=7Egjy0KjNzuZIJxRJWsk/E8FcHEcXyraB2fdi3+Pn2xdDp+NdQvVk92lTeD369tsCo
         PeEHPkU9xegowAB7v3L/pjq3eVYwUb24tGD5qJ0f8BAncLO8ZAFwGA/4WB0o5JD1SXcF
         m7aeCBtc+bTsVxjKoCONTeYp3oAI3/sDG+NuIuE7kMrrnFnFLDr6hTP18pz1aICgJHWc
         smy/aGRdkQJcdvG9JukcXJg/iZ+OVxyEgGmWDU2mtE5/A8kztw1hQ7SDkn6bFddRDetq
         l71faG3ty42BLHILR+rRsLgxK7PsdFQMuks+eghqOJjZPLg6bFFkvrVrgz+TXCUnmh3I
         EksQ==
X-Gm-Message-State: AAQBX9fXovEzASaZ4pK8epElVyQSYpH7v2eOICJZFfksoWUuAfrDdWB9
        ivheuAYwdh0/1P+oZhPfrmzPKPYFxUyjUaxBj/wnJg==
X-Google-Smtp-Source: AKy350ZmYGtwUOWne/Utk7GkQuWJqWrfqT91iS+F5pYmG3pyp7m+1ZNcdqcTZcNMTwVydR8OBM0v+g==
X-Received: by 2002:a17:902:864b:b0:1a1:d395:e85c with SMTP id y11-20020a170902864b00b001a1d395e85cmr13841905plt.0.1680031858692;
        Tue, 28 Mar 2023 12:30:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709026b0b00b0019a96d3b456sm17723739plk.44.2023.03.28.12.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 12:30:58 -0700 (PDT)
Message-ID: <24f2a3e6-804b-d9aa-ae5d-a44f71516983@kernel.dk>
Date:   Tue, 28 Mar 2023 13:30:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/8] IB/hfi1: make hfi1_write_iter() deal with ITER_UBUF
 iov_iter
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230328173613.555192-1-axboe@kernel.dk>
 <20230328173613.555192-6-axboe@kernel.dk>
 <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wj=21dt1ASqkvaNXenzQCEZHydYE39+YOj8AAfzeL5HOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/28/23 12:43?PM, Linus Torvalds wrote:
> On Tue, Mar 28, 2023 at 10:36?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Don't assume that a user backed iterator is always of the type
>> ITER_IOVEC. Handle the single segment case separately, then we can
>> use the same logic for ITER_UBUF and ITER_IOVEC.
> 
> Ugh. This is ugly.
> 
> Yes,. the original code is ugly too, but this makes it worse.

Hah I know, I did feel dirty writing that patch... The existing code is
pretty ugly as-is, but it sure didn't get better.

> You have that helper for "give me the number of iovecs" and that just
> works automatically with the ITER_UBUF case. But this code (and the
> sound driver code in the previous patch), really lso wants a helper to
> just return the 'iov' array.
> 
> And I think you should just do exactly that. The problem with
> 'iov_iter_iovec()' is that it doesn't return the array, it just
> returns the first entry, so it's unusable for this case, and then you
> have all these special "do something else for the single-entry
> situation" cases.
> 
> And iov_iter_iovec() actually tries to be nice and clever and add the
> iov_offset, so that you can actually do the proper iov_iter_advance()
> on it etc, but again, this is not what any of this code wants, it just
> wants the raw iov array, and the base will always be zero, because
> this code just doesn't *work* on the iter level, and never advances
> the iterator, it just advances the array index.
> 
> And the thing is, I think you could easily just add a
> 
>    const struct iovec *iov_iter_iovec_array(iter);
> 
> helper that just always returns a valid array of iov's.
> 
> For a ITER_IOV, it would just return the raw iov pointer.
> 
> And for a ITER_UBUF, we could either
> 
>  (a) just always pass in a single-entry auto iov that gets filled in
> and the pointer to it returned
> 
>  (b) be *really* clever (or ugly, depending on how you want to see
> it), and do something like this:
> 
>         --- a/include/linux/uio.h
>         +++ b/include/linux/uio.h
>         @@ -49,14 +49,23 @@ struct iov_iter {
>                         size_t iov_offset;
>                         int last_offset;
>                 };
>         -       size_t count;
>         -       union {
>         -               const struct iovec *iov;
>         -               const struct kvec *kvec;
>         -               const struct bio_vec *bvec;
>         -               struct xarray *xarray;
>         -               struct pipe_inode_info *pipe;
>         -               void __user *ubuf;
>         +
>         +       /*
>         +        * This has the same layout as 'struct iovec'!
>         +        * In particular, the ITER_UBUF form can create
>         +        * a single-entry 'struct iovec' by casting the
>         +        * address of the 'ubuf' member to that.
>         +        */
>         +       struct {
>         +               union {
>         +                       const struct iovec *iov;
>         +                       const struct kvec *kvec;
>         +                       const struct bio_vec *bvec;
>         +                       struct xarray *xarray;
>         +                       struct pipe_inode_info *pipe;
>         +                       void __user *ubuf;
>         +               };
>         +               size_t count;
>                 };
>                 union {
>                         unsigned long nr_segs;
> 
> and if you accept the above, then you can do
> 
>    #define iter_ubuf_to_iov(iter) ((const struct iovec *)&(iter)->ubuf)
> 
> which I will admit is not *pretty*, but it's kind of clever, I think.
> 
> So now you can trivially turn a user-backed iov_iter into the related
> 'struct iovec *' by just doing
> 
>    #define iov_iter_iovec_array(iter) \
>      ((iter)->type == ITER_UBUF ? iter_ubuf_to_iov(iter) : (iter)->iov)
> 
> or something like that.
> 
> And no, the above is NOT AT ALL TESTED. Caveat emptor.
> 
> And if you go blind from looking at that patch, I will not accept
> responsibility.

I pondered something like that too, but balked at adding to iov_iter and
then didn't pursue that any further.

But bundled nicely, it should work out quite fine in the union. So I
like the suggestion, and then just return a pointer to the vec rather
than the copy, unifying the two cases.

Thanks for the review and suggestion, I'll make that change.

-- 
Jens Axboe

