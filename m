Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8796C46166A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 14:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243526AbhK2Ncl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 08:32:41 -0500
Received: from mail.loongson.cn ([114.242.206.163]:50412 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237107AbhK2Nal (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:30:41 -0500
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax+sg11aRhCWsBAA--.2737S3;
        Mon, 29 Nov 2021 21:27:18 +0800 (CST)
Subject: Re: [PATCH v2] fuse: rename some files and clean up Makefile
To:     Stefan Hajnoczi <stefanha@redhat.com>
References: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
 <YaSpRwMlMvcIIMZo@stefanha-x1.localdomain>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7277c1ee-6f7b-611d-180d-866db37b2bd7@loongson.cn>
Date:   Mon, 29 Nov 2021 21:27:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <YaSpRwMlMvcIIMZo@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Ax+sg11aRhCWsBAA--.2737S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKF18Jr4UKFyUtw47Gr1rJFb_yoWDXFg_ur
        W5trWxuwnrXF1YyFW7Cr18XFs7Ka1vva1UZr1Yvw4rGrn8GFy3XrWqgw1I9a1xWFy8ZF45
        Grs8uan8Z3sa9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxAYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc2xS
        Y4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
        jIksDUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/29/2021 06:19 PM, Stefan Hajnoczi wrote:
> On Sat, Nov 27, 2021 at 06:13:22PM +0800, Tiezhu Yang wrote:
>> No need to generate virtio_fs.o first and then link to virtiofs.o, just
>> rename virtio_fs.c to virtiofs.c and remove "virtiofs-y := virtio_fs.o"
>> in Makefile, also update MAINTAINERS. Additionally, rename the private
>> header file fuse_i.h to fuse.h, like ext4.h in fs/ext4, xfs.h in fs/xfs
>> and f2fs.h in fs/f2fs.
>
> There are two separate changes in this patch (virtio_fs.c -> virtiofs.c
> and fuse_i.h -> fuse.h). A patch series with two patches would be easier
> to review and cleaner to backport.
>
> I'm happy with renaming virtio_fs.c to virtiofs.c:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>

Hi Stefan and Miklos,

Thanks for your reply, what should I do now?

(1) split this patch into two separate patches to send v3;
(2) just ignore this patch because
"This will make backport of bugfixes harder for no good reason."
said by Miklos.

Thanks,
Tiezhu

