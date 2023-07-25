Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F84F761D13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbjGYPO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 11:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjGYPO0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:14:26 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7481BE9
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 08:14:24 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230725151420epoutp017c68673917f11902ce136c31d669e5fb~1JSFlyPgm0594605946epoutp01t
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 15:14:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230725151420epoutp017c68673917f11902ce136c31d669e5fb~1JSFlyPgm0594605946epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690298060;
        bh=h5fyAZXUQIbBcME9y0pgsagoVTcJ5iC8zePjjoLvhXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aTQ4A1qQoyZ+ljNm0vSd7i6FTzM+qwzuhrP/wLImb1jkIKVLgOtgv1VVz0AwwlCnl
         RqgvkeohGiXr+YoowO8dz/66dk7nSk16RfFOXRVDYGpkKx190+xY+K99Lj7mENNBzr
         MZhrgO1cPwfgoBHjdeHbxb9cwpJCWdVbbTU5n0jw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230725151419epcas5p2005fdd0636dd4bf95c98ce78f08ad014~1JSE5kcJc1555015550epcas5p2U;
        Tue, 25 Jul 2023 15:14:19 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R9LCt0frFz4x9Pt; Tue, 25 Jul
        2023 15:14:18 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.B0.06099.9C6EFB46; Wed, 26 Jul 2023 00:14:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230725115145epcas5p2bdf4e5246908e9f8aceee980aa15264d~1GhNJP4CH0397103971epcas5p2x;
        Tue, 25 Jul 2023 11:51:45 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230725115145epsmtrp28faf324b02c727aa3c518448fd58aec4~1GhNIkRXG0727807278epsmtrp2O;
        Tue, 25 Jul 2023 11:51:45 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-22-64bfe6c9a7c8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.2A.64355.157BFB46; Tue, 25 Jul 2023 20:51:45 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230725115143epsmtip21293061110efab61d2129f2fdfdd2417~1GhLsKbpe3138731387epsmtip2z;
        Tue, 25 Jul 2023 11:51:43 +0000 (GMT)
Date:   Tue, 25 Jul 2023 17:18:32 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nitheshshetty@gmail.com, anuj1072538@gmail.com
Subject: Re: [PATCH] fs/read_write: Enable copy_file_range for block device.
Message-ID: <20230725114832.7dratlqxomvw2bcf@green245>
MIME-Version: 1.0
In-Reply-To: <ZL72WJ31DtAjgcFd@dread.disaster.area>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmhu7JZ/tTDG402Vh8/PqbxaJpwl9m
        i9eHPzFabDl2j9Hi5oGdTBYrVx9lstiz9ySLxeVdc9gsdjxpZLQ4//c4qwOXx6lFEh47Z91l
        99i0qpPNY/fNBjaPvi2rGD0+b5Lz2PTkLVMAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7yp
        mYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QeUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XU
        gpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IyOSw3MBV8UKzYs+MfawHhLuouRk0NCwERi
        35atTF2MXBxCArsZJd4s7WGDcD4xSuw5NJ0JpArMefpfEqbj5IsHLBBFOxkl9k/eD9X+jFHi
        /MInbCBVLAKqEut/7AGyOTjYBLQlTv/nAAmLCKhJTJq0gxmknllgEZPEw38T2UESwgI+Ev2b
        poBt4xUwk2hf8okFwhaUODnzCZjNKWAscXDyLGYQW1RARmLG0q9ggyQEZnJItJw5xQqyTELA
        RWLaXSWIS4UlXh3fwg5hS0l8freXDcIul1g5ZQUbRG8Lo8Ss67MYIRL2Eq2n+sEWMAtkSEz6
        sJAFIi4rMfXUOiaIOJ9E7+8nTBBxXokd82BsZYk16xdALZCUuPa9Ecr2kHi0eicrJIT+M0pc
        mPePaQKj/Cwkz81Csg/CtpLo/NDEOgvoH2YBaYnl/zggTE2J9bv0FzCyrmKUTC0ozk1PLTYt
        MM5LLYfHeHJ+7iZGcPLV8t7B+OjBB71DjEwcjIcYJTiYlUR4DWP2pQjxpiRWVqUW5ccXleak
        Fh9iNAVG1kRmKdHkfGD6zyuJNzSxNDAxMzMzsTQ2M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+J
        g1OqgWle7RmfdtdO1r/paiV3XhrVLw1f+taq6eeje5LnG8+tNBOVfDE/6YXdqcO3b+yrf/3x
        0qR1p5zTu/5Gvj32eEesz+aPZ6KZWdkU3hqdfD9r9bZ2lqMG568bui7vUZttcL1O9NUq5h05
        Xr6/p7LoCH1ofvuWadrT81u2uZ2UqjjGE1N79carkqcpe/5OklTrXpG4kI1n5737+yU7Yw5M
        mxR9ex6f7raVq7q1rohOf6VgobNZZGP7l/3rM3lqY1RW222fqFCs/DHgTVnSPC8myZe959Um
        MZ48qtAaZHn8ecXvFerTZp1/2/H2Ke9+noicSbF/Oj9/lI/gvxnock3Y5YhL867Mq8brT5/4
        ck02Pir6nRJLcUaioRZzUXEiAOg5nAFHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvG7g9v0pBqc/8Fh8/PqbxaJpwl9m
        i9eHPzFabDl2j9Hi5oGdTBYrVx9lstiz9ySLxeVdc9gsdjxpZLQ4//c4qwOXx6lFEh47Z91l
        99i0qpPNY/fNBjaPvi2rGD0+b5Lz2PTkLVMAexSXTUpqTmZZapG+XQJXxoplB5gLlslX7J60
        lL2BcZlkFyMnh4SAicTJFw9Yuhi5OIQEtjNKTGz8yg6RkJRY9vcIM4QtLLHy33N2iKInjBLr
        D0xgBUmwCKhKrP+xh62LkYODTUBb4vR/DpCwiICaxKRJO8B6mQWWMEnc+uYNYgsL+Ej0b5rC
        BGLzCphJtC/5BLW4kUli8bQeNoiEoMTJmU9YIJrNJOZtfsgMMp9ZQFpi+T+w+ZwCxhIHJ88C
        my8qICMxY+lX5gmMgrOQdM9C0j0LoXsBI/MqRtHUguLc9NzkAkO94sTc4tK8dL3k/NxNjOBY
        0Qrawbhs/V+9Q4xMHIyHGCU4mJVEeA1j9qUI8aYkVlalFuXHF5XmpBYfYpTmYFES51XO6UwR
        EkhPLEnNTk0tSC2CyTJxcEo1MMWW79C1rFHYxffkb869mmdHNhV6yDYwm1RdLJJXX3U2bI9V
        kXLFp2miCwXmN7X+d+Aw5r8vVfq3KXLunk2XJDq2zTw97ZBQvJffOo4dVYq59uw+j99NUfRZ
        w7jxft6EfQYN+4R2fM0K4Vog/pHvRf2cvWVeHYpXfhvXujXoFR7h+rLV9bzx/I7a3zLs9U8z
        tP0/ffpXd9+ca/odv0l7WKykXobqH7h2W6VZtEbHq3qv/b98+2I+7oRbe0r0bSbPiEi5FBMl
        sGPxNO2btZbHGZkf9R0pmWMsn9tvUKjf4K0fvnfxN/+y2D2Lqx5O+iWR+Nl7kdV1jvs7w6ee
        rbl7vWO6gv3hyVJfstQuxkSZKLEUZyQaajEXFScCAM/Z58IEAwAA
X-CMS-MailID: 20230725115145epcas5p2bdf4e5246908e9f8aceee980aa15264d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----hN0RooYYa-ItG0rOrbcpG43nsRC9v5sOSsCeQA9.xTvcVY.j=_e53bc_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230724060655epcas5p24f21ce77480885c746b9b86d27585492
References: <CGME20230724060655epcas5p24f21ce77480885c746b9b86d27585492@epcas5p2.samsung.com>
        <20230724060336.8939-1-nj.shetty@samsung.com>
        <ZL4cpDxr450zomJ0@dread.disaster.area> <20230724163838.GB26430@lst.de>
        <ZL72WJ31DtAjgcFd@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------hN0RooYYa-ItG0rOrbcpG43nsRC9v5sOSsCeQA9.xTvcVY.j=_e53bc_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

Hi Dave,

On 23/07/25 08:08AM, Dave Chinner wrote:
>On Mon, Jul 24, 2023 at 06:38:38PM +0200, Christoph Hellwig wrote:
>> > > Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
>> > > and inode_out. Allow block device in generic_file_rw_checks.
>> >
>> > Why? copy_file_range() is for copying a range of a regular file to
>> > another regular file - why do we want to support block devices for
>> > somethign that is clearly intended for copying data files?
>>
>> Nitesh has a series to add block layer copy offload,
>
>Yes, I know.
>
>> and uses that to
>> implement copy_file_range on block device nodes,
>
>Yes, I know.
>
>> which seems like a
>> sensible use case for copy_file_range on block device nodes,
>
>Except for the fact it's documented and implemented as for copying
>data ranges of *regular files*. Block devices are not regular
>files...
>
>There is nothing in this patchset that explains why this syscall
>feature creep is desired, why it is the best solution, what benefits
>it provides, how this new feature is discoverable, etc. It also does
>not mention that user facing documentation needs to change, etc
>

Agreed. I missed adding context in description.

>> and that
>> series was hiding a change like this deep down in a "block" title
>> patch,
>
>I know.
>
>> so I asked for it to be split out.  It still really should
>> be in that series, as there's very little point in changing this
>> check without an actual implementation making use of it.
>
>And that's because it's the wrong way to be implementing block
>device copy offloads.
>
>That patchset originally added ioctls to issue block copy offloads
>to block devices from userspace - that's the way block device
>specific functionality is generally added and I have no problems
>with that.
>

We moved to copy_file_range, so that we can reuse the existing infra
instead of adding another ioctl[1].

>However, when I originally suggested that the generic
>copy_file_range() fallback path that filesystems use (i.e.
>generic_copy_file_range()) should try to use the block copy offload
>path before falling back to using splice to copy the data through
>host memory, things went off the rails.
>
>That has turned into "copy_file_range() should support block devices
>directly" and the ioctl interfaces were removed. The block copy
>offload patchset still doesn't have a generic path for filesystems
>to use this block copy offload. This is *not* what I originally
>suggested, and provides none of the benefit to users that would come
>from what I originally suggested.  Block device copy offload is
>largely useless to users if file data copies within a filesystem
>don't make use of it - very few applications ever copy data directly
>to/from block devices directly...
>
>So from a system level point of view, expanding copy_file_range() to
>do direct block device data copies doesn't make any sense. Expanding
>the existing copy_file_range() generic fallback to attempt block
>copy offload (i.e. hardware accel) makes much more sense, and will
>make copy_file_range() much more useful to users on filesystem like
>ext4 that don't have reflink support...
>

Agreed. But adding all the cases is making the series heavier and harder to
iterate. So we trimmed some of the patches and feature. 
Hopefully we can get to filesystems, if the current series gets in.

>So, yeah, this patch, regardless of how it is presented, needs to a
>whole lot more justification that "we want to do this" in the commit
>message...
>

Agreed, the commit description was not conveying the things we wanted to
do. It makes sense to send block related relaxation as part of copy offload
series instead of doing it here.
However, the change to get inode pointer using mapping_host is still
independent and can go as a separate fix patch.


Thank you,
Nitesh Shetty


[1] https://lore.kernel.org/all/Y3607N6lDRK6WU7%2F@T590/

------hN0RooYYa-ItG0rOrbcpG43nsRC9v5sOSsCeQA9.xTvcVY.j=_e53bc_
Content-Type: text/plain; charset="utf-8"


------hN0RooYYa-ItG0rOrbcpG43nsRC9v5sOSsCeQA9.xTvcVY.j=_e53bc_--
