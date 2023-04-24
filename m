Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D4E6ED705
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjDXVzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDXVzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:55:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC45FDB
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:55:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b7b18a336so1306122b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682373350; x=1684965350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dtva4xOMbPvaNe8LomaYwTZ/F8t+k/gQ/K8f+ucYNco=;
        b=E8Eqs52qqmGi1sUG7R6p0kc4J8ilpqdc1NLRtwUATT5KGVWqf8bJoRn0htC/nsFOza
         2NURvMgaECwsr6YIsdh1FK/xgk7+uJcBxklfsJYrf660SnF2qZ/ECt3AtaiL0vuqLJfG
         nZIJmPXTbA2DjriVU23SDbtznrnsywWZb8MwRgIoLWSDTe6U3Jrn5vyt3rvRdU77LEfy
         MZ7buhgz+2qCyKvDgSbObWUvREQe9hI/dIak/mmTX83HyU3tI1WWIgRccilpeVBmRDD6
         x0ORA4RTuPeFi6NhMG0d8P2j5AlMUU1H30v0cfnFdtKbAIq2p8GzwGJY9bD4gmzVapZp
         1EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682373350; x=1684965350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dtva4xOMbPvaNe8LomaYwTZ/F8t+k/gQ/K8f+ucYNco=;
        b=Qp4XvSvI+kjixc27YOSANVck62zr13Wh4PfuKvj6Yh3Ib/aAIzaqlgZzkEsbSmVrUl
         87NrkCIC/yYJMwQDXAFhrvfWCcKhRos1nWg7nHo0R5xBa4z9hKHZBC124pwG4HVD54C0
         9QAT2iqqdXEbLmw0E9ohfag6pQTQUoQ5k/Olf5rcuXRHyrhs6enFzUo1M4tdMfdkYLh8
         VaXFRnerubt2k13R9IRCmVOX66TwO9EC63PiLMc8HWy7p1ZwiW0xkAbI4+FVrX0JroAS
         F9+hq5OYmPnBneeA1yWWU8Slol41jP6DujpNtHYjg4HMkNneye/CRw+J62oJu/ddu4ui
         eNKQ==
X-Gm-Message-State: AAQBX9fPX2skaq3Gu+1o8Sweiwzt9x6RxzYM8c3dLKZr3RVP+OnMWUZ6
        tIMbCHXPgDEpLDybaceI2kM0Fw==
X-Google-Smtp-Source: AKy350bCmG//1BzrGVtqGtzQYKH8egWccw0xGHszQ+bicNrMxsgJ2vBKoUblpqNvE5KVHhBR7fpk3A==
X-Received: by 2002:a05:6a00:14cf:b0:63b:5257:6837 with SMTP id w15-20020a056a0014cf00b0063b52576837mr18433868pfu.1.1682373350072;
        Mon, 24 Apr 2023 14:55:50 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p8-20020a62ab08000000b0062e0010c6c1sm7834411pff.164.2023.04.24.14.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 14:55:49 -0700 (PDT)
Message-ID: <ae8ee8f3-9960-1fd9-5471-433acacb6521@kernel.dk>
Date:   Mon, 24 Apr 2023 15:55:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
 <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/24/23 3:37?PM, Linus Torvalds wrote:
> On Mon, Apr 24, 2023 at 2:22?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> If we don't ever wait for IO with the pipe lock held, then we can skip
>> the conditional locking. But with splice, that's not at all the case! We
>> most certainly wait for IO there with the pipe lock held.
> 
> I think that then needs to just be fixed.

I took another look at this, and the main issue is in fact splice
confirming buffers. So I do think that we can make this work by simply
having the non-block nature of it being passed down the ->confirm()
callback as that's the one that'll be waiting for IO. If we have that,
then we can disregard the pipe locking as we won't be holding it over
IO.

Which is what part of this series does, notably patch 1.

Only other oddity is pipe_to_sendpage(), which we can probably sanely
ignore.

IOW, would you be fine with a v2 of this pull request where patch 2
drops the conditional locking and just passes it to ->confirm()? That's
certainly sane, and just makes the ultimate page locking conditional to
avoid waiting on IO. I'd really hate to still be missing out on pipe
performance with io_uring.

-- 
Jens Axboe

