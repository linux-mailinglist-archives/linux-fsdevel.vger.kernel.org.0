Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D612979DAB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjILV0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjILV0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:26:30 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3B410CA;
        Tue, 12 Sep 2023 14:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SnBwkUrcCOjJqpQBcRhdQIcuFP+xLH+GkZZjkSCCMGU=; b=A9aqFwZDirlcBTzi7qQm2l20bO
        ZpoeQ4uMUWlksMEtBNO1oK9MXwMOWrNeHVu8GIte8BccJQk2sNHpw0QZoSNjBMSp3a655NoqEdQXm
        JcUMPRP7ZDq+Ot0OUU6Zgt1DwolpiTvoSafdhk9fDLmXFSbeUckQg3jkZ+P4TfBofSD7N7ONGTUaz
        29cYUh9ALwemKsnFw+X1qV6vybKznrmQ47ug+Lq/S7lJj8U7LG9JcVH1r9N/q+vlyF2JxxRwq+Fct
        CPQcsraDHAGLaGaW8ssQM+STKPUaHIHWhdJl/ANz4hu3ik6SfsKNvmXSt7wcZcQgvsb5TcWSmU7xq
        3C95XMUQ==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qgAtm-002sYt-Nl; Tue, 12 Sep 2023 23:26:18 +0200
Message-ID: <6da9b6b1-5028-c0e2-f11e-377fabf1432d@igalia.com>
Date:   Tue, 12 Sep 2023 18:26:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230911182804.GA20408@twin.jikos.cz>
 <b25f8b8b-8408-e563-e813-18ec58d3b5ca@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <b25f8b8b-8408-e563-e813-18ec58d3b5ca@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/09/2023 06:20, Anand Jain wrote:
> [...]
>> I've added Anand's patch
>> https://lore.kernel.org/linux-btrfs/de8d71b1b08f2c6ce75e3c45ee801659ecd4dc43.1694164368.git.anand.jain@oracle.com/
>> to misc-next that implements subset of your patch, namely extending
>> btrfs_scan_one_device() with the 'mounting' parameter. I haven't looked
>> if the semantics is the same so I let you take a look.
>>
>> As there were more comments to V3, please fix that and resend. Thanks.
> [...] 
>    Please also add the newly sent patch to the latest misc-next branch:
>      [PATCH] btrfs: scan forget for no instance of dev
> 
>    The test case btrfs/254 fails without it.
> 

Sure Anand, thanks for the heads-up!

Now, sorry for the silly question, but where is misc-next?! I'm looking
here: https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/

I based my work in the branch "for-next", but I can't find misc-next.
Also, I couldn't find "btrfs: pseudo device-scan for single-device
filesystems" in the tree...probably some silly confusion from my side,
any advice is appreciated!

Thanks,


Guilherme
