Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7CA782E88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 18:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbjHUQhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbjHUQhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:37:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDD7102
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 09:37:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b89b0c73d7so6093825ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692635825; x=1693240625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RB2nfOBT1A3ismm3CFrhqeJeY3mSeUhzAgexBTEBF90=;
        b=knIdGwqFoE50a+5YojheTzb3RKBC7mD4l9F1YnCJ/v9dyAQc+5YGQ6zbMmLLFWRu4+
         og6sVtzvEBEYC9vqgVGCS57ZwdCLCr29sCJ6Y2pYnyx5atElUHMiEGWsnHqmnQ02wwIN
         t61O0t+FPwAZr5pdMpGR9O+C2xIEAcR/PauzIkqHtkcpdVMG8XRDI1uULKsmyuMFqi90
         n44ubel9nt0nqlOD/KtiUBquzMIhgdJoSUBcVg1ew9OoKOHqMqVRx52OkBV2VCXViFYd
         N9K/6sVrHroxzMN24jPhNs0lmJNSaxC+Hx0T8qCT+Fksnz7Kdfb9PGAeq1H0FvDcyKdj
         64zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692635825; x=1693240625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RB2nfOBT1A3ismm3CFrhqeJeY3mSeUhzAgexBTEBF90=;
        b=lqqdnno8VoWu9Se086hqfsMcaW/X3alpZzypD1yv8zEDGmWxfz68DkotID4Gn8kZfQ
         xy8hORyH+FP7UeURv4ksYdF+Sn8+xiESocTE0dDBRfA/2L8N4mBIn2aCwk8M87i6r0uf
         GIM8j0Gs8AiTf4ZqMzuIlev5U1MPn55jlLozaDoWMlyE+0t7jI9SNyCN34ULdVTfWHRj
         yaOUuirE7BUi2IpEo4y8z8GkXzgOA+ZfsRHNnxM4AzRlxY/aG2RTtxne7J7tWslrEHwz
         Tvw8vifsCeROqpVKfe+FZNqj2PuKS4iNobMPhJE6QM2+Nk3xpQ6JB4YoiIlIilEFZlG9
         nCzw==
X-Gm-Message-State: AOJu0YzRqhixPkvw87whAtw8+axYh6xD4pPot/o44YaBJNvrTgsw0/Qp
        LrJU8+mBxqgiinRvEMwu9xHW+g==
X-Google-Smtp-Source: AGHT+IEmr2/qtCDEcDAqMh1MTO6QZciQlD7lhXHaf23UC3OQnCxYZRl15E+3m24bXhsQn2KgZjkXjQ==
X-Received: by 2002:a17:90a:1348:b0:263:f36e:d610 with SMTP id y8-20020a17090a134800b00263f36ed610mr6809978pjf.0.1692635825026;
        Mon, 21 Aug 2023 09:37:05 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a1fc200b00262ca945cecsm8692792pjz.54.2023.08.21.09.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 09:37:04 -0700 (PDT)
Message-ID: <b98269e6-a2a0-4adc-be24-dfc82bec2a55@kernel.dk>
Date:   Mon, 21 Aug 2023 10:37:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] kiocb_{start,end}_write() helpers
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <20230817141337.1025891-1-amir73il@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230817141337.1025891-1-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/23 8:13 AM, Amir Goldstein wrote:
> Christian,
> 
> This is an attempt to consolidate the open coded lockdep fooling in
> all those async io submitters into a single helper.
> The idea to do that consolidation was suggested by Jan.
> 
> This re-factoring is part of a larger vfs cleanup I am doing for
> fanotify permission events.  The complete series is not ready for
> prime time yet, but this one patch is independent and I would love
> to get it reviewed/merged a head of the rest.
> 
> This v3 series addresses the review comments of Jens on v2 [1].

Looks good to me now:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

