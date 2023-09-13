Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64EE79E8EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 15:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbjIMNPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbjIMNPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:15:33 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E49019B9;
        Wed, 13 Sep 2023 06:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vGjSJZ7irWx9hYVT0F0S7Th6MFWLONBxJ6TMfDGxsR4=; b=kc5j3Zc2hPScmD3yZwsLOTbk7+
        cyOdWKpZPGAKu1E9k6Lwts2qA5ZWjI5gom+YpIXDCW3r5HZZ4znCsarrnOf1zC8SRm5B9wJHzl7tb
        O7RJyoMiaRDQnmx7w3O6+4OiaDXbu0N7FOy43tnRROzp0zQVEEPx/XC+sT7LPFDclV+3uyYxDuNmc
        Dj9obWEd3XGQYfyJaFupW/cGZpmZw/mIfVmS1B0kwU7+5kn2m0rmBY2q5mi2rKXFpYhc080RExWQV
        bTi1ulbYuUuRZTzuJstB8ngtG0iTu6LoOsxmz0K6RZlvSvTc3FP1phYbJDciuWlSy5uBEOMwMkNOv
        L1MS8VJA==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qgPiF-003JWu-3p; Wed, 13 Sep 2023 15:15:23 +0200
Message-ID: <e89b4997-5247-556e-9aee-121b4e19938e@igalia.com>
Date:   Wed, 13 Sep 2023 10:15:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230911182804.GA20408@twin.jikos.cz>
 <b25f8b8b-8408-e563-e813-18ec58d3b5ca@oracle.com>
 <6da9b6b1-5028-c0e2-f11e-377fabf1432d@igalia.com>
 <4914eb22-6b51-a816-1d5b-a2ceb8bcbf06@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <4914eb22-6b51-a816-1d5b-a2ceb8bcbf06@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/09/2023 21:39, Anand Jain wrote:
> [..] 
>> Now, sorry for the silly question, but where is misc-next?! I'm looking
>> here: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/
>>
>> I based my work in the branch "for-next", but I can't find misc-next.
>> Also, I couldn't find "btrfs: pseudo device-scan for single-device
>> filesystems" in the tree...probably some silly confusion from my side,
>> any advice is appreciated!
> 
> 
> David maintains the upcoming mainline merges in the branch "misc-next" here:
> 
>     https://github.com/kdave/btrfs-devel.git
> 
> Thanks.
> 

Thanks a lot Anand!

Checking now, I could also find it in the documentation - my bad, apologies
