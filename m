Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33045554A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 21:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358007AbiFVThh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 15:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356638AbiFVThg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:37:36 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3B15580
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jun 2022 12:37:34 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g186so17015732pgc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jun 2022 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vLSA30lDdLkkDZbTdMy4zEFSQCe7LQsCuNdhdhUVnyc=;
        b=fQW3sLitv3yqKwsN0CNXkWDviWem6C1hxi+U9qy+SOHKKXJGHBat0NNdlUvxXvbAvq
         9IUjlFZMndOYMzqbhmcUuR0IXdM7XQ5XLtI0iFqD+XK1HoLX2fuSJPy5d/gYpFyO7fY6
         xZq/IWr8kBiAsAk5ulZDp1dn9Vnkux8oZ0Jsonc7JWyR3MbnXfc88UiLZMPEKzfAZ+7A
         Y6/ebrzPu2QqLLEUccMSfE638uTvx1g8TcJFpg5IoCv9HfYJHUJjrjaPP/7yn0BxiiWB
         LAZri9n4DdmvQGCZhHS5pcEkuz4hVfix9vEKvcJY3uc8gplytTDUJ6aLsH3ZL7IF2ziD
         4Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vLSA30lDdLkkDZbTdMy4zEFSQCe7LQsCuNdhdhUVnyc=;
        b=fVjviC8Eyala0TC8JmbBip1EzoIqJSiMDqbx45g8dfGD0WengGm5o9NEBgki5+27OD
         6t0GcisVQ/TlHC878PWvQNc58nAMvqUVoGA2+RDPZwYBHvUWGz7q/2PwbDWuELXYYhzl
         faeEylzI9hbYoJmTa9sGkjt0Q28P2k22Dp+kEAO9alOp4O+r5beaBKW9PRidr/aWspkG
         4pPtPaMG9yuI5a40oFKe2ZPQw2lJgX1OxD+WyAnpylzJN8K8KToTnDf+modkfh7utA+6
         hrkrpazEtxmMlFGSZq2VWhm3oVejfsEaqJisjo4s4NtXPmStmA09m5/3jnypfMyZ3Tlm
         KIfw==
X-Gm-Message-State: AJIora9PZ4pefxH6Pvr5io1NPrlACBE3fqa0GvpY+KKt2wzu47ii5m6v
        E6h3i+VHq5h9JEQBm1CKrMQQFA==
X-Google-Smtp-Source: AGRyM1u6MpW/YCDLzqSgNzS2v8MbvkZDkPP/YeigD8Li9EZ7Wn53yh1D2KPX9MW9S3XrJQpMreg+JQ==
X-Received: by 2002:a63:9c4:0:b0:401:a7b6:ad18 with SMTP id 187-20020a6309c4000000b00401a7b6ad18mr4295807pgj.523.1655926654185;
        Wed, 22 Jun 2022 12:37:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y21-20020a056a00191500b005252867671esm4596595pfi.66.2022.06.22.12.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 12:37:33 -0700 (PDT)
Message-ID: <18355997-11e3-b511-f0cd-59c806fef6f1@kernel.dk>
Date:   Wed, 22 Jun 2022 13:37:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 00/14] io-uring/xfs: support async buffered writes
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, jack@suse.cz,
        hch@infradead.org
References: <20220616212221.2024518-1-shr@fb.com>
 <d18ffe14-7dd2-92a7-abd0-673b7da62adb@kernel.dk>
 <YrNvCGmBcqS80kNG@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YrNvCGmBcqS80kNG@casper.infradead.org>
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

On 6/22/22 1:35 PM, Matthew Wilcox wrote:
> On Wed, Jun 22, 2022 at 11:41:14AM -0600, Jens Axboe wrote:
>> Top posting - are people fine with queueing this up at this point? Will
>> need a bit of massaging for io_uring as certain things moved to another
>> file, but it's really minor. I'd do a separate topic branch for this.
> 
> I haven't had time to review this version, and I'm not likely to have
> time before July 4th.

I think Stefan addressed your previous concerns. But it's not like the
merge window is around the corner, but would be nice to get some -next
coverage in the mean time. So I don't think you being away should hold
up that part, and there will still be time to take a look once you're
back.

-- 
Jens Axboe

