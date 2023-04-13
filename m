Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5546E1679
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 23:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDMV1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 17:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMV1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:27:48 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A98F5FDB
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 14:27:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B6D155C0068;
        Thu, 13 Apr 2023 17:27:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Apr 2023 17:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm3; t=1681421264; x=
        1681507664; bh=cbd2I7CVENdYtdNBaDPSmXl6wIHpwDXuYKolclR648I=; b=e
        wCXukDjxg+1coSgtx1sQNYZKQbxz6p20kNtoLrfWLuZIcmInjcPhrb8NSx36LSfT
        bEvqOFaV8+mdKRm3XK4zBVboC68i3kU+ZSfIVtbSWl0dZNzzGp5U1i5ncR7nzKwW
        0Y3vy0H0li2sF2MfkAPLCVf/FdxFwUueR9kmn0e76owsY7bsLn2aWaDqgnUaw6GE
        1Fxr1iUYD/FUvU7uqQ6KPxH99xLoykRPbLox4L/ayHlhjTxxA9JctQWw9KmWHF5K
        fnCLbSKl/2lYRu063fBpj9m5+WSl3yIONSOwruTuZL+2uyNEWgBnJeg8LHrVJIc3
        Ed2cE980F7IyftEMwqV1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1681421264; x=1681507664; bh=c
        bd2I7CVENdYtdNBaDPSmXl6wIHpwDXuYKolclR648I=; b=gQwVrb9766FYVLm4A
        VRgtyaA0mMPwsiERWuZ81yX6OeuAH5puMkuiyk3aMCK46XfxPmdGmvcCkbjaeHGX
        g8Wj7fpIfqYYjCLC8nc/5WjyX6wywSjg2ceDdwdTZDpfAhi4Tf5vQtZgkfky6mL4
        yqUN6wHwybFNqT6zXqXEm+rvmPIIEHesCVGfShMvTQIiQ6haHZr03phj6/Iq8Yg1
        W7v68bSSauq8hElfqEJWRnQ8Zyct/XEwnW7UbQTslXxcccJCybglJZQ8IyCfy96R
        W4MH8RlCS87u6s+Epj04Qv3J0+lotgHrV9UzAQlEeTfj6fv5J3Vm0Xu5TqTwCk72
        SFVzg==
X-ME-Sender: <xms:0HM4ZIpQn0SsyhihzUGI_QJ9I1-6SQPtH2BVsdhMsCeQMcd4yO-95Q>
    <xme:0HM4ZOpiX41y29WbGUvXsHrXLjxNXS4S_fkzCUgzQGjnSqcqM0A8514yBMliDcB8g
    slUlSdpCrJXRWAL>
X-ME-Received: <xmr:0HM4ZNOxk_fJAorvjkSnWijssNovLio6uDaC_R9HAcgMdsg74lzZMQsWWZCOzMjRRpO44e3g5qUC_cycg4jce7sCrWLfxtUKCpGw2SedjP9FvGp6iBEp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfvvefhufgtgfesthejredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeeuueehhfeifedtgeegieevkeegfedvfffgvdet
    veehjeekveehfeekjedvkedvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:0HM4ZP60DUmrlNVqEpsmZfViIQ4_ngl1D09veJyHBr6bp-NA3A4BOw>
    <xmx:0HM4ZH4I3sXIMpKdVEwC8J0S1TLZDNPt-5iZ6TthxV3L1ZuKDSpYEw>
    <xmx:0HM4ZPhtOVQU4-UpRk2f1L3VQ-2710aJSmsUd905KLC9BJY498olsA>
    <xmx:0HM4ZBQiO_QS578dwZgUQO0AbtVJoGkvi1N6xKU2X8NS9YwrzBnS5Q>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 17:27:43 -0400 (EDT)
Message-ID: <aae918da-833f-7ec5-ac8a-115d66d80d0e@fastmail.fm>
Date:   Thu, 13 Apr 2023 23:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US, de-DE
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: sequential 1MB mmap read ends in 1 page sync read-ahead
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I found a weird mmap read behavior while benchmarking the fuse-uring patches.
I did not verify yet, but it does not look fuse specific.
Basically, I started to check because fio results were much lower
than expected (better with the new code, though)

fio cmd line:
fio --size=1G --numjobs=1 --ioengine=mmap --output-format=normal,terse --directory=/scratch/dest/ --rw=read multi-file.fio


bernd@squeeze1 test2>cat multi-file.fio
[global]
group_reporting
bs=1M
runtime=300

[test]

This sequential fio sets POSIX_MADV_SEQUENTIAL and then does memcpy
beginning at offset 0 in 1MB steps (verified with additional
logging in fios engines/mmap.c).

And additional log in fuse_readahead() gives

[ 1396.215084] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64 index=0
[ 1396.237466] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64 index=255
[ 1396.263175] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1 index=254
[ 1396.282055] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1 index=253
... <count is always 1 page>
[ 1496.353745] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1 index=64
[ 1496.381105] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64 index=511
[ 1496.397487] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1 index=510
[ 1496.416385] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1 index=509
... <count is always 1 page>

Logging in do_sync_mmap_readahead()

[ 1493.130764] do_sync_mmap_readahead:3015 ino=132 index=0 count=0 ras_start=0 ras_size=0 ras_async=0 ras_ra_pages=64 ras_mmap_miss=0 ras_prev_pos=-1
[ 1493.147173] do_sync_mmap_readahead:3015 ino=132 index=255 count=0 ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0 ras_prev_pos=-1
[ 1493.165952] do_sync_mmap_readahead:3015 ino=132 index=254 count=0 ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0 ras_prev_pos=-1
[ 1493.185566] do_sync_mmap_readahead:3015 ino=132 index=253 count=0 ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0 ras_prev_pos=-1
...
[ 1496.341890] do_sync_mmap_readahead:3015 ino=132 index=64 count=0 ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0 ras_prev_pos=-1
[ 1496.361385] do_sync_mmap_readahead:3015 ino=132 index=511 count=0 ras_start=96 ras_size=64 ras_async=64 ras_ra_pages=64 ras_mmap_miss=0 ras_prev_pos=-1


So we can see from fuse that it starts to read at page index 0, wants
64 pages (which is actually the double of bdi read_ahead_kb), then
skips index 64...254) and immediately goes to index 255. For the mmaped
memcpy pages are missing and then it goes back in 1 page steps to get
these.

A workaround here is to set read_ahead_kb in the bdi to a larger
value, another workaround might be (untested) to increase the read-ahead
window. Either of these two seem to be workarounds for the index order
above.

I understand that read-ahead gets limited by the bdi value (although
exceeded above), but why does it go back in 1 page steps? My expectation
would have been

index=0  count=32 (128kb read-head)
index=32 count=32
index=64 count=32
...


This is with plain 6.2 + fuse-uring patches.

Thanks,
Bernd
