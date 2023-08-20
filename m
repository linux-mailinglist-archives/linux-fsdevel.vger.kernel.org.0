Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA3781F3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Aug 2023 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHTSV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Aug 2023 14:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjHTSVy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Aug 2023 14:21:54 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9BF19A2;
        Sun, 20 Aug 2023 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NKvDh3qKmqM+ONQTyOCnRZXo6IjNE0prIx7wEgyM+Zc=; b=MyVcMsjezrrzRlbhJ8Nru2xuu/
        zvAsFST2B/dvEDt35Lt4ecVWU7wT3hoyUJ6L6vwfYEze3aNk2Ha9KYp4nUsjHZONJijwFYRseqNiJ
        bVhLt+DY5G4cQHwT8m4Y/02u7GdCReIkQbrDPs6iv2F7ou9EPKl1s0xtUDWW9tSn63OSHRgVep4Ml
        0EVnnNmJSFmxqWKahKAnwzJv2YilUTJTf4xE7PgPKaROMjV4M2M4A0uEhzJJ9baeVr73wc5tQSBjQ
        UmRDO5uVqB0JK4DdP8ajEz/txDc5xXDig2JCh9YP5VCaeQLtZ9NOooLD7ARcvwwrB2ZGiqcNrc22X
        9kXx5xzg==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qXmz6-00CBqk-Oy; Sun, 20 Aug 2023 20:17:09 +0200
Message-ID: <6583e347-579b-a187-cc6a-2d03202619c5@igalia.com>
Date:   Sun, 20 Aug 2023 15:16:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] btrfs: Add parameter to force devices behave as
 single-dev ones
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, anand.jain@oracle.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230803154453.1488248-1-gpiccoli@igalia.com>
 <20230803154453.1488248-4-gpiccoli@igalia.com>
 <20230817154441.GC2934386@perftesting>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230817154441.GC2934386@perftesting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/08/2023 12:44, Josef Bacik wrote:
> [...]
> Now this one I'm not a fan of.  For old file systems you can simply btrfstune
> them to have your new flag.  Is there a reason why that wouldn't be an option?
> 
> If it is indeed required, which is a huge if, I'd rather this be accomplished a
> mount option.  I have a strong dislike for new mount options, but I think that's
> a cleaner way to accomplish this than a module option.  Thanks,
> 

Thanks Josef, for your feedback. I'm also not a fan of this module
parameter, and agree that a mount option would be more interesting if
that's indeed a requirement.

But I've discussed internally and it seems we can live without this one,
I'll drop it for next version.

Cheers,


Guilherme
