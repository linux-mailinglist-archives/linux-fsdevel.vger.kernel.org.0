Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF1378DBB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbjH3ShX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245162AbjH3OiP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:38:15 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53922193
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 07:38:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 9FDC83200921;
        Wed, 30 Aug 2023 10:38:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 30 Aug 2023 10:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693406287; x=1693492687; bh=H1SSAJSFlSgYfQvwjD9VE5T8h2DuhYBkoJv
        BhBH+zxw=; b=Y8h8Y9fftZxnul+oKZ9jW+WRan/7mRZo2Y3PNzQargzjpqW6B0U
        gT5jH4lRzwS7kUaf6d60P4CuNeY8rjg80pTpbffDgUosJ8HqGkZ5vk8xvuoaGzrx
        KqQYmk6eX1Yj3oqdWyY2r5QuZmVRgGkzs2SXokbkK9o2e53ooFoP6QQ8dCk8Y/MV
        vGuutswdu7CzLLVLwYA3praku8Q85E3jhqzk4LgYjmfbhJzI5tlndF9w5K+e2wVX
        1eZkW/sFSgB23cuvKNgTLZcgRG05u1M6W+oOChX8tzQDHou4UbtFGIVHXzI5Jw+H
        O6UoVKWOZJdz9gIsmHRWwrW+68ewS7l7wJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693406287; x=1693492687; bh=H1SSAJSFlSgYfQvwjD9VE5T8h2DuhYBkoJv
        BhBH+zxw=; b=FvrLmvusSATeAXVO5X3qW9Vo1G2yq29BWYiXqaZkzSLopDbKfme
        v1fhZA0xFDqbSz1qeg3FWwfHA9gf620RXJkVR8jXbi9oy1ujaJgjyAnjbpiGRYpV
        kowf0/5tEXZLUNA3QU7Aw9E/b1Gty12I6ijuQxXAqYK6jLTtKeOpSeCqPY6vHrpg
        XTprpgeSLdmaY48tpV5YVLWn2odKjTolU+FewEtZv/4sK8Oqrqth+phtV+SWV/0d
        kGwmbKFOmN3XU5M8fUbfxvEDZycF4cJc7yR8UMqZcDbU/WYKLzIU6xEnJ+J8P78w
        p1J9Afguvotl46defgKMmvo+3DHA5S96JkQ==
X-ME-Sender: <xms:TlTvZAIUmA9ja0PA5KP-ldENbufJSgVa5LXyAsxODlAiSVDOPbJqsQ>
    <xme:TlTvZAJtiLu2o9xFzIXjaQsEHCeDobLTmuuKRhgN1ZSY70bt14bS1MdoEBnAJt3Iy
    93AsHXCu6eNMDiR>
X-ME-Received: <xmr:TlTvZAuOPpwoGTu3mczXbxtGLSECc0rs86HJ2wSIK6ZQ-gcRj4vJaSW3Wl4ivvOZQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegrrghkvghfsehfrghsthhmrghilhdrfhhmqeenucggtf
    frrghtthgvrhhnpedugfdukedtveeuvedtiefhtdeivdfgueejheeuiefgjeffkeduueei
    heffgfeuvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrghkvghfsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:TlTvZNbIR3ubwAJZgiEX41AY-eOwjnP0VlhqyjO9Oq2H2EZwshgdUw>
    <xmx:TlTvZHaLjPHXqErbn5DtmKNeFrbadVQu9iDZV9HkZ3fbJGnfTvX4Ew>
    <xmx:TlTvZJAB0oOJye5WEwJSGYRFvfziTx7UL-EpKrOycvD8m4kfC7ofOg>
    <xmx:T1TvZGWPzA1kL08Cl-7F_8yUrQo989NPoFXk9xB9AQvxUgyJ-PA05Q>
Feedback-ID: id8a84192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Aug 2023 10:38:05 -0400 (EDT)
Message-ID: <77a8edad-0a26-aed5-2ee3-956a96a034de@fastmail.fm>
Date:   Wed, 30 Aug 2023 16:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/6] fuse: Allow parallel direct writes for O_DIRECT
Content-Language: en-US
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        dsingh@ddn.com, Hao Xu <howeyxu@tencent.com>
References: <20230829161116.2914040-1-bschubert@ddn.com>
 <20230829161116.2914040-4-bschubert@ddn.com>
 <CAJfpegsGLTiWvjfoZs9fAQ0xWK-QBwtAXe5_Msr_jiY4Rjssxg@mail.gmail.com>
From:   Bernd Schubert <aakef@fastmail.fm>
In-Reply-To: <CAJfpegsGLTiWvjfoZs9fAQ0xWK-QBwtAXe5_Msr_jiY4Rjssxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/30/23 15:28, Miklos Szeredi wrote:
> On Tue, 29 Aug 2023 at 18:11, Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> Take a shared lock in fuse_cache_write_iter. This was already
>> done for FOPEN_DIRECT_IO in
>>
>> commit 153524053bbb ("fuse: allow non-extending parallel direct
>> writes on the same file")
>>
>> but so far missing for plain O_DIRECT. Server side needs
>> to set FOPEN_PARALLEL_DIRECT_WRITES in order to signal that
>> it supports parallel dio writes.
> 
> Hmm, I think file_remove_privs() needs exclusive lock (due to calling
> notify_change()).   And the fallback case also.
> 
> Need to be careful with such locking changes...

Hrmm, yeah, I missed that :( Really sorry and thanks!

I guess I can fix it if by exporting dentry_needs_remove_privs. I hope 
that is acceptable. Interesting is that btrfs_direct_write seems to have 
the same issue.

btrfs_direct_write
	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode))
		ilock_flags |= BTRFS_ILOCK_SHARED;
...
	err = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
...	
	err = btrfs_write_check(iocb, from, err);
...
			ret = file_remove_privs(file);


I think that can be fixed as well after exporting 
dentry_needs_remove_privs().


Btw, why is fuse_direct_write_iter not dropping privileges? That is 
another change I need to document...


Another issue I just see is that it needs to check file size again after 
taking the lock.


Thanks a lot for your review,
Bernd




