Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5EC7429C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjF2Pf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 11:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjF2Pfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:35:55 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B57419BA
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 08:35:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D6ED5C00A1;
        Thu, 29 Jun 2023 11:35:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 29 Jun 2023 11:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688052951; x=1688139351; bh=JzhI/U4sIbHQH3o1bYQPhyqslbW1lDfwXTP
        1/xM+Hc4=; b=CBRu2KNOrT11zhOldbBNerMRqXeiSl2NW7jR/K2fUUdiM7o2L3q
        JMCC6gZhWQFcDa1QO22QD6qw+46GCn7HX5fxAPbm0IC2p3FKUej1J3KNDsgdTF89
        027pVzr5charGw7ZvUqtHqYp6pM+9bEizkDSc8vXDpLMtLRzeGdmJn+m2MZBk32N
        JVWzK8W3yg4alg4ChJAzLeCZT/cPzjhkcmFJfBQlzzCsWRJi+RkD0uF66ZUZYrQF
        4lMCaW727xfJsRxrX3vmTxS1oDcPLWH+fjTNqxj/BqQPuax1llKocY4UEapVILSe
        nD7dZZrEtNUC4jYA3GvDQDT20dAyD1cnofg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688052951; x=1688139351; bh=JzhI/U4sIbHQH3o1bYQPhyqslbW1lDfwXTP
        1/xM+Hc4=; b=Ti4DKNImRVN4GRGtB6YKU5eh7NQncoIynR/C4pjiS5TqiwT3MHF
        sYocEGblVgNbRWlH6G78tyUXnpfChOmBmQFsAW8NVYacRWULLH3xB/4YiVz80apF
        wEB9a+4wkozTSia0KwFOsajbmTQZrJnHqw8LQb26OEylmhTwikaNoVmrv3mTDYZl
        pse5nMJW8gAv8sUDQy6cHHSEhXxDH8PTcci/YIF5dGMd4EJtcx8YZA0Rp932fNzI
        wPKtpMIDhfUTnlF4lowIiNTWysBh20jBM1PudvSv5w0zifYQyPffydLzFhlzAYME
        qwRaP4+wqz15TJaEqvKW57GneVbGjx/BYNA==
X-ME-Sender: <xms:1qSdZOi12grKvhGQN9HeNorzn-SjqLLiTX0glyfmKONzPlIohW6--Q>
    <xme:1qSdZPD_Y0jWQnhDsSoRl0YePKQJpKsqnyYUrXRf2QZghxeWLQi-BLFEJWepoPf8S
    8M1eG8WdsP50CMA>
X-ME-Received: <xmr:1qSdZGHxJbOpeI8c-QrR9mnXU_86rtVUBi4K-Yua7MHb8p4SpccJW6tY0wx0CAGpSBIDUmLOaoN7sMJc_814uz98AVuS61BiHePXGFuDNcIrlDBhmjR_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpefgudevueevveeiudejveeffeejkeegvdduheek
    vdefhfetgeegheekkeetleehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdr
    shgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:1qSdZHRYVEYhpp4bahN4AoOoyRYotBKdKlAMHg3gAlPsyvrda6FzzQ>
    <xmx:1qSdZLyllRjae0mFFxI1JTp-T7bO5E_71gq3zQRV962QO3Gj_qiGTw>
    <xmx:1qSdZF4V1TykU_IQGRzdO7SusNeHGG6zJTGbIGxuHkeN7JNCbqj9aQ>
    <xmx:16SdZNtynPtlpj99_joi0NQCFUeGerCEOQ4S5krU_Pi2bItAGb3-DA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jun 2023 11:35:49 -0400 (EDT)
Message-ID: <51e0eafe-2339-534a-fea0-68c9570483a4@fastmail.fm>
Date:   Thu, 29 Jun 2023 17:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [fuse-devel] [RFC PATCH] fuse: invalidate page cache pages before
 direct write
Content-Language: en-US, de-DE
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, cgxu519@mykernel.net,
        Wanpeng Li <wanpengli@tencent.com>, miklos@szeredi.hu
References: <20230509080128.457489-1-hao.xu@linux.dev>
 <0625d0cb-2a65-ffae-b072-e14a3f6c7571@linux.dev>
 <7da6719c-23ee-736e-6787-1aad56d22e07@fastmail.fm>
 <40ed526b-a5b0-cae1-0757-1bdfeb1002a6@linux.dev>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <40ed526b-a5b0-cae1-0757-1bdfeb1002a6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hao,

On 6/29/23 14:00, Hao Xu wrote:
> Hi Bernd,
> 
> On 6/27/23 02:23, Bernd Schubert wrote:
>>
>>
>> On 6/8/23 09:17, Hao Xu wrote:
>>> Ping...
>>>
>>> On 5/9/23 16:01, Hao Xu wrote:
>>>> From: Hao Xu <howeyxu@tencent.com>
>>>>
>>>> In FOPEN_DIRECT_IO, page cache may still be there for a file, direct
>>>> write should respect that and invalidate the corresponding pages so
>>>> that page cache readers don't get stale data. Another thing this patch
>>>> does is flush related pages to avoid its loss.
>>>>
>>>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>>>> ---
>>>>
>>>> Reference:
>>>> https://lore.kernel.org/linux-fsdevel/ee8380b3-683f-c526-5f10-1ce2ee6f79ad@linux.dev/#:~:text=I%20think%20this%20problem%20exists%20before%20this%20patchset
>>>>
>>>>   fs/fuse/file.c | 14 +++++++++++++-
>>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>> index 89d97f6188e0..edc84c1dfc5c 100644
>>>> --- a/fs/fuse/file.c
>>>> +++ b/fs/fuse/file.c
>>>> @@ -1490,7 +1490,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv 
>>>> *io, struct iov_iter *iter,
>>>>       int write = flags & FUSE_DIO_WRITE;
>>>>       int cuse = flags & FUSE_DIO_CUSE;
>>>>       struct file *file = io->iocb->ki_filp;
>>>> -    struct inode *inode = file->f_mapping->host;
>>>> +    struct address_space *mapping = file->f_mapping;
>>>> +    struct inode *inode = mapping->host;
>>>>       struct fuse_file *ff = file->private_data;
>>>>       struct fuse_conn *fc = ff->fm->fc;
>>>>       size_t nmax = write ? fc->max_write : fc->max_read;
>>>> @@ -1516,6 +1517,17 @@ ssize_t fuse_direct_io(struct fuse_io_priv 
>>>> *io, struct iov_iter *iter,
>>>>               inode_unlock(inode);
>>>>       }
>>>> +    res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
>>>> +    if (res)
>>>> +        return res;
>>>> +
>>>> +    if (write) {
>>>> +        if (invalidate_inode_pages2_range(mapping,
>>>> +                idx_from, idx_to)) {
>>>> +            return -ENOTBLK;
>>>> +        }
>>>> +    }
>>>> +
>>>>       io->should_dirty = !write && user_backed_iter(iter);
>>>>       while (count) {
>>>>           ssize_t nres;
>>>
>>
>> Is this part not working?
>>
>>      if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
>>          if (!write)
>>              inode_lock(inode);
>>          fuse_sync_writes(inode);
>>          if (!write)
>>              inode_unlock(inode);
>>      }
>>
>>
> 
> 
> This code seems to be waiting for already triggered page cache writeback
> requests, it's not related with the issue this patch tries to address.
> The issue here is we should invalidate related page cache page before we
> do direct write.

oh, right, I just see it. I think you should move your 
filemap_write_and_wait_range() call above that piece in order to ensure 
it is send to the daemon/server side.


Thanks,
Bernd
