Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3817476EE97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 17:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbjHCPrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 11:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjHCPrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:47:40 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE8E46;
        Thu,  3 Aug 2023 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g53JI35Ya+f3cg7nFgZvAXgxfqleH+xo2uWT20BABOk=; b=SgQopheHqGnBDutqG1zO9O+xoG
        +QklVUX3yQGMaBWhdzQE7kfkMKs35d9TSwWVR45S96Anr9nBvxeRJWZyEWlIYWbqA5Ex25sP0LWa3
        WNFqfiqv5Y6SHkIvwYkg0dqp3Z/wGxx29UVKekf7TTNhpEkwajtovh+tEcShvb5db1FjZbxXxoIY1
        JAvIspDd+lr2Bp/SH9WudakyAqLZ59wcN92R83Me1X9ND2pf7oEO4Arj8Pg6BR1VEq+PdUQ4H3fhl
        HVNJrDEoGfZ2+ea/Mn2UrznpsmD4HdnC88um5gqsX41iQRlNkZ9Zq1wSkOKKsX/PWJfqVKCG+rEJy
        h2xMVyag==;
Received: from [201.92.22.215] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qRaY4-00Bu0e-V9; Thu, 03 Aug 2023 17:47:37 +0200
Message-ID: <a06d48d4-6816-d10d-f71e-50a27cd033de@igalia.com>
Date:   Thu, 3 Aug 2023 12:47:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230504170708.787361-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05/2023 14:07, Guilherme G. Piccoli wrote:
> [...]

Hi folks, V2 sent here:
https://lore.kernel.org/linux-btrfs/20230803154453.1488248-1-gpiccoli@igalia.com/

Thanks,


Guilherme
