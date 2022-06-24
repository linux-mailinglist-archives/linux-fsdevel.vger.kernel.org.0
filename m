Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CFA559CB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiFXOxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 10:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiFXOwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:52:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C07FD26
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jun 2022 07:48:54 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id 9so1641803ill.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jun 2022 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DWcyz906WJfvMFL2VVjgjsdhhZt0R2JBG5BvPCvlnPE=;
        b=kAZfa4Gvw0mMhZjLyDIabymc1EmZA6j/Ij9km3tKCr2BFPbswn26/J6hUzgzxK1udT
         LXghN15N0v7AXCHZjA2DZSNUqDb8GKoz3EPZn168zMo/kyOYC8fhdWqF/to68Cm5uxLi
         KUmvke0fE3Nb+xs/xxNlvH/wfLHfkCsapDQ8szgjNP6dRJ5TGPFoxdXQ3s+3EWsusHWR
         9J/fh9bzOC3ORimLqxSc/OtThU3lq68I5z0UVi8MeqqhfTtGrGxDnG19KA2TV9dSV3bW
         BgGazgp0V8riFQG6oC8SqJWq18ANKzv8SntphwIcsljLarq5zbbOYF/a54oGxURUkgY4
         Aq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DWcyz906WJfvMFL2VVjgjsdhhZt0R2JBG5BvPCvlnPE=;
        b=JFa8s0oDufONwaR2ioKbCQEEEHVYFm0iwmbYGnqpyrqLyuvxMzetNfs+eMWqRuVSfV
         Trr3UkJiTi9cXnlrxSLVCikCaBS2cXqH7Eva5fbXGRUvHqzusA8bZwtSU2BaR7jMcqxv
         vR0VknZEWTnkrdwgDbFAMo4OdyXkEr3r4MiFK8hZqAvYG9+F9HXMmA80snK4AtgV8yhS
         DSZp6Yr2CfJoIsr80eePQs24BJ2jHwwhC4WxxOuXlyOWMbNcOmI9tB1CquocdIIPF/us
         90RZolSA5MKcXX84HInUUVQRugJtouG0sCUG799F3pCvXSApDRLwf2uIHJy8C6lwTofF
         29WA==
X-Gm-Message-State: AJIora/UW2F7zNld6xzXpBZ2ONMAfhq16uVAFrD5RK1x+q1P54oytlEv
        1Yp9lHVcN63mgOTKMKgZbLbFbw==
X-Google-Smtp-Source: AGRyM1vtQ5lI0ui69eAPGDOvVUnSBy1LS9YB7l1nUJUBdVR6AuykMTvdZaQ+wwkP8ETAWatGVBndKg==
X-Received: by 2002:a05:6e02:1ba3:b0:2d8:d74b:8ff6 with SMTP id n3-20020a056e021ba300b002d8d74b8ff6mr8714104ili.264.1656082134104;
        Fri, 24 Jun 2022 07:48:54 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e25-20020a0566380cd900b00339ee768069sm1137354jak.74.2022.06.24.07.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 07:48:53 -0700 (PDT)
Message-ID: <293e593d-2f2a-623e-bf2f-786fce623327@kernel.dk>
Date:   Fri, 24 Jun 2022 08:48:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RESEND PATCH v9 07/14] fs: Add check for async buffered writes
 to generic_write_checks
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Stefan Roesch <shr@fb.com>
Cc:     io-uring@vger.kernel.org, kernel-team@fb.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, jack@suse.cz, willy@infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
References: <20220623175157.1715274-1-shr@fb.com>
 <20220623175157.1715274-8-shr@fb.com> <YrVJvA+kOvjYJHqw@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YrVJvA+kOvjYJHqw@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/23/22 11:21 PM, Christoph Hellwig wrote:
> FYI, I think a subject like
> 
> "fs: add a FMODE_BUF_WASYNC flags for f_mode"
> 
> might be a more descriptive.  As the new flag here really is the
> interesting part, not that we check it.

Agree on that - if others do too, I can just make that edit.

-- 
Jens Axboe

