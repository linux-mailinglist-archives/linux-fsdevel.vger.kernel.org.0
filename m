Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DDF6A1533
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 04:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjBXDKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 22:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXDKO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 22:10:14 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD2F5EEFE;
        Thu, 23 Feb 2023 19:10:11 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PNFHz0FcBz4f3vfW;
        Fri, 24 Feb 2023 11:10:07 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP4 (Coremail) with SMTP id gCh0CgBn0LOLKvhjD7fTEA--.35663S3;
        Fri, 24 Feb 2023 11:10:04 +0800 (CST)
Subject: Re: [LSF/MM/BPF TOPIC] Image-based read-only filesystem: further use
 cases & directions
To:     xiang@kernel.org
References: <Y7vTpeNRaw3Nlm9B@debian>
Cc:     lsf-pc@lists.linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        guohanjun@huawei.com
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <249fd0e8-3024-219a-30fa-7298bf2370fb@huaweicloud.com>
Date:   Fri, 24 Feb 2023 11:10:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y7vTpeNRaw3Nlm9B@debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBn0LOLKvhjD7fTEA--.35663S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4kZF4rAF1rKFyrWw13twb_yoWrtw4rpF
        Z5KrWUKr4ruFn7CrWkXr429F4rGws5tay5Jw15KayfZF15KF9F9rZ29r48uFW7XrW8J3Wj
        vwsIvFyFvrWqyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/1/9 16:43, Gao Xiang wrote:
> Hi folks,
> 
> * Background *
> 
> We've been continuously working on forming a useful read-only
> (immutable) image solution since the end of 2017 (as a part of our
> work) until now as everyone may know:  EROFS.
> 
> Currently it has already successfully landed to (about) billions of
> Android-related devices, other types of embedded devices and containers
> with many vendors involved, and we've always been seeking more use
> cases such as incremental immutable rootfs, app sandboxes or packages
> (Android apk? with many duplicated libraries), dataset packages, etc.
> 
> The reasons why we always do believe immutable images can benefit
> various use cases are:
> 
>  - much easier for all vendors to ship/distribute/keep original signing
>    (golden) images to each instance;
> 
>  - (combined with the writable layer such as overlayfs) easy to roll
>    back to the original shipped state or do incremental updates;
> 
>  - easy to check data corruption or do data recovery (no matter
>    whether physical device or network errors);
> 
>  - easy for real storage devices to do hardware write-protection for
>    immutable images;
> 
>  - can do various offline algorithms (such as reduced metadata,
>    content-defined rolling hash deduplication, compression) to minimize
>    image sizes;
> 
>  - initrd with FSDAX to avoid double caching with advantages above;
> 
>  - and more.
> 
> In 2019, a LSF/MM/BPF topic was put forward to show EROFS initial use
> cases [1] as the read-only Android rootfs of a single instance on
> resource-limited devices so that effective compression became quite
> important at that time.
> 
> 
> * Problem *
> 
> In addition to enhance data compression for single-instance deployment,
> as a self-contained approach (so that all use cases can share the only
> _one_ signed image), we've also focusing on multiple instances (such as
> containers or apps, each image represents a complete filesystem tree)
> all together on one device with similar data recently years so that
> effective data deduplication, on-demand lazy pulling, page cache
> sharing among such different golden images became vital as well.
> 
> 
> * Current progresses *
> 
> In order to resolve the challenges above, we've worked out:
> 
>  - (v5.15) chunk-based inodes (to form inode extents) to do data
>    deduplication among a single image;
> 
>  - (v5.16) multiple shared blobs (to keep content-defined data) in
>    addition to the primary blob (to keep filesystem metadata) for wider
>    deduplication across different images:
> 
>  - (v5.19) file-based distribution by introducing in-kernel local
>    caching fscache and on-demand lazy pulling feature [2];
> 
>  - (v6.1) shared domain to share such multiple shared blobs in
>    fscache mode [3];
> 
>  - [RFC] preliminary page cache sharing between diffenent images [4].
> 
> 
> * Potential topics to discuss *
> 
>  - data verification of different images with thousands (or more)
>    shared blobs [5];
> 
>  - encryption with per-extent keys for confidential containers [5][6];
> 
>  - current page cache sharing limitation due to mm reserve mapping and
>    finer (folio or page-based) page cache sharing among images/blobs
>    [4][7];
> 
>  - more effective in-kernel local caching features for fscache such as
>    failover and daemonless;
> 
>  - (wild preliminary ideas, maybe) overlayfs partial copy-up with
>    fscache as the upper layer in order to form a unique caching
>    subsystem for better space saving?
> 

Hello Xiang and all,

We interested in these topic too. Our cloud products will also want to use
erofs + overlayfs as container's base image and want to do more researchs on
deduplication, page cache sharing and disk space saving, and I also have some
study on overlayfs partial copy-up feature. I hope we could have further
discussion on this topic in person.

Thanks,
Yi.


>  - FSDAX enhancements for initial ramdisk or other use cases;
> 
>  - other issues when landing.
> 
> 
> Finally, if our efforts (or plans) also make sense to you, we do hope
> more people could join us, Thanks!
> 
> [1] https://lore.kernel.org/r/f44b1696-2f73-3637-9964-d73e3d5832b7@huawei.com
> [2] https://lore.kernel.org/r/Yoj1AcHoBPqir++H@debian
> [3] https://lore.kernel.org/r/20220918043456.147-1-zhujia.zj@bytedance.com
> [4] https://lore.kernel.org/r/20230106125330.55529-1-jefflexu@linux.alibaba.com
> [5] https://lore.kernel.org/r/Y6KqpGscDV6u5AfQ@B-P7TQMD6M-0146.local
> [6] https://lwn.net/SubscriberLink/918893/4d389217f9b8d679
> [7] https://lwn.net/Articles/895907
> 
> Thanks,
> Gao Xiang
> .

