Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA60680B63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 11:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbjA3K5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 05:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbjA3K5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:57:07 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CD331E27;
        Mon, 30 Jan 2023 02:57:04 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P54rB511Xz4f3jZL;
        Mon, 30 Jan 2023 18:56:58 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgAXgSt4otdjy_MHCg--.30573S2;
        Mon, 30 Jan 2023 18:56:59 +0800 (CST)
Subject: Re: [PATCH v3 0/2] Fixes for fscache volume operations
To:     linux-cachefs@redhat.com, David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>
References: <20230113115211.2895845-1-houtao@huaweicloud.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <70586435-8c17-6da7-2971-3fbb3ebe6036@huaweicloud.com>
Date:   Mon, 30 Jan 2023 18:56:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230113115211.2895845-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgAXgSt4otdjy_MHCg--.30573S2
X-Coremail-Antispam: 1UD129KBjvJXoW7trWkXw1xXw4UAFWUJw1UJrb_yoW8Gr1rpF
        ZxCwsIqFW8G3sayws7Ja17Z34v9FW8J397Wr15Jw4UAr4YvFWjqay5K3WY93W7C395Aayx
        XF1Utw4Sq34jkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

Could you please pick it up for v6.2 ?

On 1/13/2023 7:52 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patchset includes two fixes for fscache volume operations: patch 1
> fixes the hang problem during volume acquisition when the volume
> acquisition process waits for the freeing of relinquished volume, patch
> 2 adds the missing memory barrier in fscache_create_volume_work() and it
> is spotted through code review when checking whether or not these is
> missing smp_mb() before invoking wake_up_bit().
>
> Comments are always welcome.
>
> Chang Log:
> v3:
>  * Use clear_and_wake_up_bit() helper (Suggested by Jingbo Xu)
>  * Tidy up commit message and add Reviewed-by tag
>
> v2: https://listman.redhat.com/archives/linux-cachefs/2022-December/007402.html
>  * rebased on v6.1-rc1
>  * Patch 1: use wait_on_bit() instead (Suggested by David)
>  * Patch 2: add the missing smp_mb() in fscache_create_volume_work()
>
> v1: https://listman.redhat.com/archives/linux-cachefs/2022-December/007384.html
>
>
> Hou Tao (2):
>   fscache: Use wait_on_bit() to wait for the freeing of relinquished
>     volume
>   fscache: Use clear_and_wake_up_bit() in fscache_create_volume_work()
>
>  fs/fscache/volume.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>

