Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE066E4B9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjDQOiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 10:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDQOiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:38:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5CCE47
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 07:38:18 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b875d0027so533170b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681742298; x=1684334298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1lnTthz24vefodmN6ugGo9H2U7TPajzkbuPFoPBdnA=;
        b=woBdWrWLE7noCIP1vUzD98WR14HMh5KR33REtPq+sJaUfWnKPjnRL/ndFdXK8G2LS+
         oAaBYxo3EUgg81pXU2B3S2pKPPDj3vbjQmdyb0Qq3PDq8LL7lP3qDGzXtw6k8o4dnLp/
         KcDae7b0hVqi9WI5TqHs6DqOt+G6AOlnm5StMQd9stU/u7I6SgfJYXjfyKvfBeTRquGO
         O/GhVuCgOGn7+E00Fn8IUjEUpr8QuLLrNWnlo6CQJ6ft3oWzAj5sJp4HAepwVj9oHlDV
         77yqC3xbfgfI7vGg/1yV9MksP0G7rakSTyxJdbXm5Q/Ebj+mzJQ3jfMoxz5yq5yDesRv
         Pf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681742298; x=1684334298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1lnTthz24vefodmN6ugGo9H2U7TPajzkbuPFoPBdnA=;
        b=AsnXXTe2I68lnB9b7sq4vOxNSEjG7wvR8dQdl/knGszrjdSrTqS2srLeoAWuSDQ72B
         pz/IVczOlGThu5O5J4XaE4RD2CLq5gBoRRTphReKml9pIwnNs4wFowcztbS14P/F4I/f
         /eY5joWLvuaxlfVcrHswNlw+x8t81PE05yPOimGE819saHFsHC2rfFxetbJ+8TdgxqOf
         ME1VQz/kfvWJ6gbUbbCLB6hBNa+g4MWqlxGaJ2J1NLYwyOBtfQAq42s4QnP0NxE82lAD
         G8F7bdJihLSNSqIUo8Wy5yWJzpbflKwNjan2k6eWJduFgu0AiSu5pSMFqCzjNKMVkV14
         jDCg==
X-Gm-Message-State: AAQBX9fP4WS2kJxirrY3WrCY9LW8jdUNdSyU/n8WAJTkNJwGXYF489Qj
        Gn6ykJ9JPeXo5kIa5VrdurV87g==
X-Google-Smtp-Source: AKy350Zl3q0jra5rG0dWw/J18EZCPXbWyFp63Gw+8GZMcyamt91xVjS1Nx+XG2JKJ/JLF4oW+/gT+A==
X-Received: by 2002:a17:902:ecc4:b0:1a6:9a20:f234 with SMTP id a4-20020a170902ecc400b001a69a20f234mr14243095plh.2.1681742297609;
        Mon, 17 Apr 2023 07:38:17 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ix3-20020a170902f80300b001a69918611csm6142370plb.72.2023.04.17.07.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 07:38:17 -0700 (PDT)
Message-ID: <817984a2-570c-cb23-4121-0d75005ebd4d@kernel.dk>
Date:   Mon, 17 Apr 2023 08:38:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore eventfd
 to reduce cpu utilization
Content-Language: en-US
To:     wenyang.linux@foxmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, Fu Wei <wefu@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/16/23 5:31?AM, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> For the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
> then a read(2) returns 8 bytes containing that value, and the counter's
> value is reset to zero. Therefore, in the NON SEMAPHORE scenario,
> N event_writes vs ONE event_read is possible.
> 
> However, the current implementation wakes up the read thread immediately
> in eventfd_write so that the cpu utilization increases unnecessarily.
> 
> By adding a configurable delay after eventfd_write, these unnecessary
> wakeup operations are avoided, thereby reducing cpu utilization.

What's the real world use case of this, and what would the expected
delay be there? With using a delayed work item for this, there's
certainly a pretty wide grey zone in terms of delay where this would
perform considerably worse than not doing any delayed wakeups at all.

-- 
Jens Axboe

