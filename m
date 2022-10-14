Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC85FF0B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJNO6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJNO6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:58:14 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F58A1946E5;
        Fri, 14 Oct 2022 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kelky+eVwv2Q20yZzcQet2723DHRyec/jgZYHrjNAHk=; b=rcLAkiSpOA9rqfxJDX+rjl/LNM
        G8Z25wZKMleC504EqFVqoqLekdATfsVqbeUUQNCZ94tUX0mI4bfA8cBy2bQWxYPxwhXZqTr7O5jcJ
        Sl3YAh9tyi02OYWYt1qf36YPZ555Gs20Hwrqn5crhKsOy+g7Xkz9/dTykoyyCig/41b6MkxLICMb+
        r0o3tYo1ywdwyU77F1cduT9aP5PWOxjr4PvSL4NO01d7vF5MCTdyz6/pmREbOaF0+NJ9I29pJf9GE
        d4uNIwK+i6oR5t9nFZO3KtpDiEdgEuSjdVAzn8dCovVflK4KXgDV9ceLJ3uMvKPCAcO1R7RT1lsvS
        P3oLnffQ==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ojM8S-001SEE-MU; Fri, 14 Oct 2022 16:58:05 +0200
Message-ID: <1c6a9461-0d3d-a049-0165-0d5c95aa9405@igalia.com>
Date:   Fri, 14 Oct 2022 11:57:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2 3/3] efi: pstore: Add module parameter for setting the
 record size
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
References: <20221013210648.137452-1-gpiccoli@igalia.com>
 <20221013210648.137452-4-gpiccoli@igalia.com>
 <CAMj1kXG7syjMsOL+AcUMfT0_nhGde6qc_6MexpdDtxFQpS2=7A@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXG7syjMsOL+AcUMfT0_nhGde6qc_6MexpdDtxFQpS2=7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/10/2022 11:46, Ard Biesheuvel wrote:
> [...]
>>         for (;;) {
>> -               varname_size = EFIVARS_DATA_SIZE_MAX;
>> +               varname_size = record_size;
>>
> 
> I don't think we need this - this is the size of the variable name not
> the variable itself.
> 

Ugh, my bad. Do you want to stick with 1024 then?
Thanks,


Guilherme
