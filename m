Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EFE79F0B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjIMR6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjIMR6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:58:15 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D06819AE;
        Wed, 13 Sep 2023 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LemBAllpSB+nBVeYPpXhlF4/jD1MnenidN0W/OMh2xg=; b=Evw27BSARKab/Enl5NkiknGg4v
        gcpcJVwus5Q0cXoTHlm+L8IBSLZe2CAf4GtO0qkPK6/rGpQELwzY3dAMyMKy817EmqG3pRSOYVLw4
        NL03mKuUxvE6DKHsBbB1P+zx8h2PNWIbIyzWKmKJDYSnzUkkJiyk+72gOd9yWOctCmXMKKjCS+9gv
        XpG3y29dUUILX3CDX7Byrsaofx9SawV5jxvzoGszr0ySiitXUEys8CDj2zZkyCQ8hxPObFNjfiQPo
        byrFP9vWEak+vZyRHLDlGyceMWxwd8ATTDJkwvK3t04hxGqw0072P76WKc/Yte2hZsJFpjFosm91g
        hgvuNBmA==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qgU7q-003Rkm-BM; Wed, 13 Sep 2023 19:58:06 +0200
Message-ID: <70157a92-8eda-813e-82ba-02102b7b039a@igalia.com>
Date:   Wed, 13 Sep 2023 14:58:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
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
 <e89b4997-5247-556e-9aee-121b4e19938e@igalia.com>
 <20230913173224.GX20408@twin.jikos.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230913173224.GX20408@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/09/2023 14:32, David Sterba wrote:
> [...]
>> Checking now, I could also find it in the documentation - my bad, apologies
> 
> It's documented at https://btrfs.readthedocs.io/en/latest/Source-repositories.html
> but it can be always improved. If the page contents was incomplete from
> you POV please let me know or open an issue at
> github.com/kdave/btrfs-progs .
> 

Indeed, it's there and from my perspective, it's very fine as is, I just
missed that, silly me heh

Cheers!
