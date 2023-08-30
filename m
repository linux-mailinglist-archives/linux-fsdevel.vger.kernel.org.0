Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0C478DB01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjH3SiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243870AbjH3MAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:00:51 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B631B0;
        Wed, 30 Aug 2023 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kjFpwM2xu0IM8xc9RfcUZFYWV0WkUr533BDclRZkPy4=; b=Ul8k2Rbr88lhf3y32rAu+afX6A
        hYy7xUu6c2zOWKkuCNM0tZHS6wvYbpOHlobypCFANdqfMMxf9xLoi0z+51D/ZumEcFo8rYrKbKScY
        PvtBDLcHzbjz2xjiebK1MkLchJC+qW/D76CqsrDh6I7VI1G1ci7os4GoBRzmxuseYFx3Av6hRpzO8
        OI49wGvwfwETqdDC7LQn/IEfIxRg+lueOnfvDBH4HUciEn+nUt8Ar6w2Fx2JIZlG6nXbXYAc4Cw1+
        AzPC503Dxvq0eBr0cKk5e1+0XnB91db5gtWcHKp6P1DjvDPz5gRu7FTB9GJsaKnJIiHKMCQ2yHKGS
        3rZV8VDQ==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qbJs8-00HMh1-EI; Wed, 30 Aug 2023 14:00:32 +0200
Message-ID: <748fbfb3-5467-afeb-f93a-e072fabf985f@igalia.com>
Date:   Wed, 30 Aug 2023 09:00:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>
Cc:     clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, david@fromorbit.com, kreijack@libero.it,
        johns@valvesoftware.com, ludovico.denittis@collabora.com,
        quwenruo.btrfs@gmx.com, wqu@suse.com, vivek@collabora.com,
        dsterba@suse.com, josef@toxicpanda.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-3-gpiccoli@igalia.com>
 <9bd1260f-fe69-45ba-1a37-f9e422809bff@igalia.com>
 <ff5c53fa-e808-0dbe-6f08-bfaa945ced4c@oracle.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <ff5c53fa-e808-0dbe-6f08-bfaa945ced4c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/08/2023 04:11, Anand Jain wrote:
> [...]
> Yeah, we need sysfs entries for the new feature and test cases that 
> generally rely on it to determine whether to skip or run the test case.
> 
> The paths would be:
> - /sys/fs/btrfs/features/..
> - /sys/fs/btrfs/<uuid>/features/..
> 
> These paths emit only output 0. The presence of the sysfs file indicates 
> that the feature is supported.
> 
> Thanks,
> Anand
> 

Thanks a lot Anand!
