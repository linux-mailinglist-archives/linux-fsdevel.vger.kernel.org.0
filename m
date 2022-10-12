Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A925FC8AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 17:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJLPvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJLPvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:51:12 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580227FFB7;
        Wed, 12 Oct 2022 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nEbf/siCGkGv7ZDAYpR4vqV4raB403QmjiUpggtSBAI=; b=eHAf0WpPwGSpbKuq+ay8LX9yf4
        MNMfkj2sRREg68NWmmJJGWm4gphf/SNch3xqDEzxcFsy7f8YynTK4Rb1XxoxXLdetoJyaDa7EDk+1
        Y+EAOv/0wsIYoE1qkFJyPXSjVafnam0vmUWATceLPQc4Yvs+uUQ1UtJ6cwcS50PLzQz2+jaQe5m4d
        FG3AqE1QlSr9JC4xdlpI+ltvanptTg/R3qrz0t/iCAw5jQuNgsJ6PewM8/PO3J0cE4wvtrYA1d3eS
        BDXaV13+/FMQHUdRpAdWT2T4iHNVOcpHIqU917opaSbOUaA0ay7AXzximFp4zbwRUSA+3hWvKL6NZ
        ah2NOE/w==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oie0f-000HpG-H0; Wed, 12 Oct 2022 17:51:05 +0200
Message-ID: <839e44ed-ae89-dfd4-9c38-978ce2693910@igalia.com>
Date:   Wed, 12 Oct 2022 12:50:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 0/8] Some pstore improvements
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        kernel-dev@igalia.com, linux-efi@vger.kernel.org
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <166509868540.1834775.12982405101524535051.b4-ty@chromium.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <166509868540.1834775.12982405101524535051.b4-ty@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/10/2022 20:24, Kees Cook wrote:
> On Thu, 6 Oct 2022 19:42:04 -0300, Guilherme G. Piccoli wrote:
>> overall. Most of them are minors, but the implicit conversion thing
>> is a bit more "relevant" in a sense it's more invasive and would fit
>> more as a "fix".
>>
>> The code is based on v6.0, and it was tested with multiple compression
>> algorithms (zstd, deflate, lz4, lzo, 842) and two backends (ramoops and
>> efi_pstore) - I've used a QEMU UEFI guest and Steam Deck for this goal.
>>
>> [...]
> 
> Applied to for-next/pstore, thanks!
> 
> [1/8] pstore: Improve error reporting in case of backend overlap
>       https://git.kernel.org/kees/c/55dbe25ee4c8
> [2/8] pstore: Expose kmsg_bytes as a module parameter
>       https://git.kernel.org/kees/c/1af13c2b6324
> [3/8] pstore: Inform unregistered backend names as well
>       https://git.kernel.org/kees/c/a4f92789f799
> 

Thanks Kees! just a heads-up on how I'll proceed.

(a) Patches 1-3 were added already.

(b) MAINTAINERS patch was reworked by yourself in the other series, so
I'll discard my version.

(c) I'll rework patches 4 and 8 and re-submit them plus patch 7
(including the ACK from Ard).

(d) Gonna discard for now patch 5, planning to test a new version on top
of the crypto acomp interface V2 from Ard/you.

Cheers,


Guilherme
