Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AB86E1684
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 23:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjDMVdP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 17:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDMVdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:33:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A163269E
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 14:33:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3FC295C00B4;
        Thu, 13 Apr 2023 17:33:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 Apr 2023 17:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1681421591; x=1681507991; bh=Il0eEIqNhqBU8ECHfwauUNcYJt9ebk7gt+h
        3fhmjFGc=; b=YyyRC314q/dOGJbm3084kqHXIIoNdSkABdDNoMaY7wQTt1ebsU2
        6QbdsFLDVMxdmrAu0JQ60PZhYNEqTYh5vRtu/dsLJIP56staGvbQyCb/vlbAWOvr
        Aits8j57GQqxYPs/ha5ad5jrzbW+/+b+/OVmeoSf6uFhyIoGI2by50+GkKAf1IOn
        /lFLTwtfOnHqdvHuUUw+kXuuO+58uqjtsQDZiV0FN33l9GSot7rKIed73+RXr+2T
        9lJednC1wchn9X0x+A5uFou/gvhGVLMryzbpMrEa94ebKf8kZVblC0gsufxbgahs
        kIRMPj1ezf0QG1IMx0nMZAkNCBxgUquU9Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681421591; x=1681507991; bh=Il0eEIqNhqBU8ECHfwauUNcYJt9ebk7gt+h
        3fhmjFGc=; b=PKyz5a1GBus+8U9NINMGS+SAQn3OZxB22mvwGfa1uw0kKYDw1aw
        /fjjMA9hZBlNuEY109j8zM6jXERF+HRjWsINNVLEW7q5ltDNcFrUsk0I5Dw2lRBp
        GChYh9dnj7In24/ZDs5PPRyTtoxuNdiyruVvhYZDst5SwkunKD54wx19MXkvoh+6
        APlG8X4/rmRYCkpp/juXqoRdgYwc9UkLas04bPJ+KQgbolpbYQNWSoa2NE0wkcpF
        YiA1Q4cEHIsksFMjuAQaIYMgCqUoSiogx7Ll6TM4cjLOuyDhWytDzruono9PrK9H
        ASKftv+iTiENLRexp5FOTQhwYILYrQFFK5w==
X-ME-Sender: <xms:F3U4ZIyGtWvS0x2oA_7rqsDi6r7HWUOdzAWLdmwes5c-OQeVjB18GQ>
    <xme:F3U4ZMQtMqwaAaqP3drkBedD3DrDT6xBQUjsKQ9_rdpD5RI63nqRfSkMGQxIaXYwr
    WNHygNuq9R8vWUm>
X-ME-Received: <xmr:F3U4ZKXsi4ZqUlLA3i0bBO6M_wX8NepFv54P__uHX8Nk8a-h6g2KDWSwV22vQGdauXvKKevovK3Pmytkdru-PGZm38ylSHjHZeKJ4FWpRqr71hckKFsx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuhffvvehfjggtgfesthekredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeduteejuedtvddtudfffeduudehvddvhfeg
    leehteevgfekhfelgefhfffgtedutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:F3U4ZGhsL4N99SEhW6f6L6a4TyJWNeIQI5ACxfPXOrbwf36rRRkPvQ>
    <xmx:F3U4ZKBcutKfAykirG2P0ki9GYNnNAJ3WJByb-vLnF0blzbg-hB2vQ>
    <xmx:F3U4ZHLM98ytcIEh_FjVe-78yocYFIV3Q2Dj6qPFpDSqFxILuZt7hg>
    <xmx:F3U4ZFOODpRy10xcS8ELLihGBPmKFWW-RZ8t53x5eO4piJtiIOf2Ew>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 17:33:10 -0400 (EDT)
Message-ID: <df5c4698-46e1-cbfe-b1f6-cc054b12f6fe@fastmail.fm>
Date:   Thu, 13 Apr 2023 23:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: sequential 1MB mmap read ends in 1 page sync read-ahead
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <aae918da-833f-7ec5-ac8a-115d66d80d0e@fastmail.fm>
In-Reply-To: <aae918da-833f-7ec5-ac8a-115d66d80d0e@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry, forgot to add Andrew and linux-mm into CC.

On 4/13/23 23:27, Bernd Schubert wrote:
> Hello,
> 
> I found a weird mmap read behavior while benchmarking the fuse-uring 
> patches.
> I did not verify yet, but it does not look fuse specific.
> Basically, I started to check because fio results were much lower
> than expected (better with the new code, though)
> 
> fio cmd line:
> fio --size=1G --numjobs=1 --ioengine=mmap --output-format=normal,terse 
> --directory=/scratch/dest/ --rw=read multi-file.fio
> 
> 
> bernd@squeeze1 test2>cat multi-file.fio
> [global]
> group_reporting
> bs=1M
> runtime=300
> 
> [test]
> 
> This sequential fio sets POSIX_MADV_SEQUENTIAL and then does memcpy
> beginning at offset 0 in 1MB steps (verified with additional
> logging in fios engines/mmap.c).
> 
> And additional log in fuse_readahead() gives
> 
> [ 1396.215084] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64 
> index=0
> [ 1396.237466] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64 
> index=255
> [ 1396.263175] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1 
> index=254
> [ 1396.282055] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1 
> index=253
> ... <count is always 1 page>
> [ 1496.353745] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1 
> index=64
> [ 1496.381105] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64 
> index=511
> [ 1496.397487] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1 
> index=510
> [ 1496.416385] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1 
> index=509
> ... <count is always 1 page>
> 
> Logging in do_sync_mmap_readahead()
> 
> [ 1493.130764] do_sync_mmap_readahead:3015 ino=132 index=0 count=0 
> ras_start=0 ras_size=0 ras_async=0 ras_ra_pages=64 ras_mmap_miss=0 
> ras_prev_pos=-1
> [ 1493.147173] do_sync_mmap_readahead:3015 ino=132 index=255 count=0 
> ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0 
> ras_prev_pos=-1
> [ 1493.165952] do_sync_mmap_readahead:3015 ino=132 index=254 count=0 
> ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0 
> ras_prev_pos=-1
> [ 1493.185566] do_sync_mmap_readahead:3015 ino=132 index=253 count=0 
> ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0 
> ras_prev_pos=-1
> ...
> [ 1496.341890] do_sync_mmap_readahead:3015 ino=132 index=64 count=0 
> ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0 
> ras_prev_pos=-1
> [ 1496.361385] do_sync_mmap_readahead:3015 ino=132 index=511 count=0 
> ras_start=96 ras_size=64 ras_async=64 ras_ra_pages=64 ras_mmap_miss=0 
> ras_prev_pos=-1
> 
> 
> So we can see from fuse that it starts to read at page index 0, wants
> 64 pages (which is actually the double of bdi read_ahead_kb), then
> skips index 64...254) and immediately goes to index 255. For the mmaped
> memcpy pages are missing and then it goes back in 1 page steps to get
> these.
> 
> A workaround here is to set read_ahead_kb in the bdi to a larger
> value, another workaround might be (untested) to increase the read-ahead
> window. Either of these two seem to be workarounds for the index order
> above.
> 
> I understand that read-ahead gets limited by the bdi value (although
> exceeded above), but why does it go back in 1 page steps? My expectation
> would have been
> 
> index=0  count=32 (128kb read-head)
> index=32 count=32
> index=64 count=32
> ...
> 
> 
> This is with plain 6.2 + fuse-uring patches.
> 
> Thanks,
> Bernd
