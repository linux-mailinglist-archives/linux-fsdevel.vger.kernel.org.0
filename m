Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376685426A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiFHGog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 02:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348967AbiFHF6m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:58:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E9445CB5D
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 21:31:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n28so25453428edb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jun 2022 21:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lQzGWzSzNym33MQ84Y+l0IYApxkDWXsfpOoAO4fDHlI=;
        b=pLcIgzoF06q+6p7bNMxbfyeIE4USudtWpeFahTUvEnR7xMfelU2/kdyscp0xEzX39O
         7F0y8uzCOtb+mZZMSlT27TPASU2K/shDy0TCDGhjgqPupzzLX4mh0tUrI9xkRgoL2L3C
         XuEGpxyF5MqhnqdknPMsjAPoWxsyQ5KPyOvH4NHOPGZkW3ds/2o61RSNL0Ynqt1Y1VdG
         Bfd76BmUlSqRAXXVDA2CV/UTWJVjcfAkMB9lNC0Ud/ky7YG1dM1S8jv6FqlwgjECA/IT
         qdjfu9Wvf2AxBL9OQ+F2eH+lrRAcunRWSRcpGZCba31FBX1TobN8MBKOdQaqyorboDyH
         unMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lQzGWzSzNym33MQ84Y+l0IYApxkDWXsfpOoAO4fDHlI=;
        b=um3A4KOFsbk1QzBySR0f1Kq71sIrr/FhZ/Sr7uXFbqOvnuaes0birKlu3L9f7j26lt
         +2n3QVO7iRh8EScdBwd72VXJ0asrsKvCEjrCMcGw2avi0WQTf/wPYzzgDO0orJSZC4xp
         6KGe/N+Nv730Wi8WLnHswLJAxhOSK3zs+rjS1Ijt7hC4zyKtiAFF3s4WZwaCqvBnK/Hq
         bvkHwVVJ0qALMACkcQB21p5kynPBhtj6isNJZQZaMzp6qTsUTYqPY6/NY8F+aQXW+e9O
         iV+86G/OdmGbdvErx5Zpa2kl+IGFCvio8FI7+TwdusPVv1m0aEL0Xj/Bmrha5U03+X48
         wggw==
X-Gm-Message-State: AOAM531WPUIWnm9gF6y4n0vDISHNkYp2XXbxq8OI9/SyUeink/WxVd06
        P5k+8dC5+oPAaBnZt8k5z5Vl7g==
X-Google-Smtp-Source: ABdhPJz8pE9/Vjr7/i5C+fk0/UyWIJaVLXaAMlSya4uBXn9u4OSqYRLr3nLBaRZ5u6D83V8/t2c8dA==
X-Received: by 2002:a50:fc10:0:b0:42d:cbd2:4477 with SMTP id i16-20020a50fc10000000b0042dcbd24477mr36791934edr.363.1654662673432;
        Tue, 07 Jun 2022 21:31:13 -0700 (PDT)
Received: from [192.168.1.99] ([80.208.69.52])
        by smtp.gmail.com with ESMTPSA id u15-20020a05640207cf00b0042dd60352d1sm11550692edy.35.2022.06.07.21.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 21:31:12 -0700 (PDT)
Message-ID: <539fb998-bbc2-b630-6549-ed8fe23fa167@kernel.dk>
Date:   Tue, 7 Jun 2022 22:31:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC 0/5] support nonblock submission for splice pipe to pipe
Content-Language: en-US
To:     Hao Xu <hao.xu@linux.dev>, Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>
References: <20220607080619.513187-1-hao.xu@linux.dev>
 <d350c35e-1d73-b2c8-5ae4-e6ead92aebba@gmail.com>
 <68b1a721-217a-f52b-ae41-0faec77edf3f@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <68b1a721-217a-f52b-ae41-0faec77edf3f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/7/22 10:19 PM, Hao Xu wrote:
> On 6/7/22 17:27, Pavel Begunkov wrote:
>> On 6/7/22 09:06, Hao Xu wrote:
>>> From: Hao Xu <howeyxu@tencent.com>
>>>
>>> splice from pipe to pipe is a trivial case, and we can support nonblock
>>> try for it easily. splice depends on iowq at all which is slow. Let's
>>> build a fast submission path for it by supporting nonblock.
>>
>> fwiw,
>>
>> https://www.spinics.net/lists/kernel/msg3652757.html
>>
> 
> Thanks, Pavel. Seems it has been discussed for a long time but the
> result remains unclear...For me, I think this patch is necessary for
> getting a good SPLICE_F_NONBLOCK user experience.

I'd just take it up again, this is something we do need to get done to
avoid io-wq offload. Which is important...

-- 
Jens Axboe

