Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A07A55AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 00:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjIRWVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjIRWVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:21:41 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EC78F;
        Mon, 18 Sep 2023 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vs718sPz71SsHq42Vsd9pPxhEVtcgVbZKqSzR0nS1Hs=; b=lPZaDcPrZolLfjy0jtBlUNWdH2
        53G71699fcG5sHPT3K25TDpmmxIj963fcMR2aqxoYw033NX+BYbaop88fCvcrxkVnS8Vnc136kjmO
        mN9fQs2m7WSF/3AX8XiW0dL5JV/xHM4BmqvpsRhUeSmmOWrC8rLIxXgllgCILMqSOoxzFM8GlFjJ5
        bXVEKh9EV7Utp272EK2vs9Vvd7XZz47D5iKJP6fOYHbIpiD3zmYquo01eY1spq8zCnXPuZNy54KEW
        0B6tQ1tN3VO6O5IB09UkAcV4Z86wyR/3+kRW9LKNwCrqtijl4poFDXRymphfPZGaanXjSeelhxRn0
        7Cb6zWCw==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qiMcR-005svI-LE; Tue, 19 Sep 2023 00:21:28 +0200
Message-ID: <cff46339-62ff-aecc-2766-2f0b1a901a35@igalia.com>
Date:   Mon, 18 Sep 2023 19:21:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/2] btrfs: Introduce the temp-fsid feature
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, anand.jain@oracle.com,
        david@fromorbit.com, kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230913224402.3940543-1-gpiccoli@igalia.com>
 <20230913224402.3940543-3-gpiccoli@igalia.com>
 <20230918215250.GQ2747@twin.jikos.cz>
Content-Language: en-US
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230918215250.GQ2747@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/09/2023 18:52, David Sterba wrote:
> [...]
> Let's stick to temp-fsid for now, I like that it says the fsid is
> temporary, virtual could be potentially stored permanently (like another
> metadata_uuid).
> 
> I've added the patch to for-next, with some fixups, mostly stylistic.
> I'll add the btrfs-progs part soon so we have the support for testing.
> The feature seems to be complete regarding the original idea, if you
> have any updates please send them separate patches or replies to this
> thread. Thanks.
> 

Thanks a bunch David, much appreciated!
BTW, thanks a lot all reviewers, was a great and productive discussion.

For testing, likely you're aware but I think doesn't harm to mention
here as well: there's a fstests case for this feature here ->

https://lore.kernel.org/linux-btrfs/20230913224545.3940971-1-gpiccoli@igalia.com/

Cheers,


Guilherme
