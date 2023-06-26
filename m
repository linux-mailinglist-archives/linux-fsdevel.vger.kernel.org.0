Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FA073E867
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 20:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjFZSZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 14:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjFZSZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:25:16 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E7295A
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 11:24:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 695755C006C;
        Mon, 26 Jun 2023 14:23:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 26 Jun 2023 14:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687803837; x=1687890237; bh=pBPcyXVQcMEwlTM+Dnsk9E+eLu5slHNFy0b
        YTO0+8ok=; b=nogYACru8dE3PcZ7tLo/liTVYtLEQbkCR/n/Veq46eN/K96hwmf
        amVks5sPCHFgP6LlpW4gGLwjlszjrJT7/HMcszCa3DiQ2sUqP2MSGu5iCHiPzdc1
        8uoDRJhmciv97Vibct8dkShtw3etNJWaqxI81/PkPJvsflT6C/8SBelOmD1yLgQD
        2H/I06xtMa4SKEcwbuUGpVYTp7a4c2841p14lD8WbdeEJmKE1eLsEd3iTCiuI9C8
        mEsR+bN1nOlBXPAI6YsPsE5tKUVfYkyCOAfJE19zLziOMz7Lz7uovPxQmtWF4vtx
        nkA/F9MhaznVYBcKaixq0k9l975q2m9DG4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687803837; x=1687890237; bh=pBPcyXVQcMEwlTM+Dnsk9E+eLu5slHNFy0b
        YTO0+8ok=; b=CvDagTCzTlnfWd2FzmitQORWTIEAA6kBRifUJz0zaJZIfFxWzhF
        r1VeTeAow7Mrt+b33SQysiMEFSStGKsgmOGf+a6t0rS80WnKbfLr885MSTpNdsXY
        SYUZsMYvRYyTUK6jN9dnN4czjvApnTzam817DmcGrmAWXKwK9Ww3rr5sSUcTaG7U
        YId9PDUaTEaGqZ/Pzkqz6l6woI2874xxjYYZ5N0RLi4ik+AOaSj1zR6A70X2ZUEZ
        LbPdY/rkgZ2X2rmHg4OlbTI1nTtVEL6hgFqmkyJHyrqzIZ6fnQ16H6cUnV0Ryasu
        rdEW9vxXab/hFkzv7ljcYcIuUQHQsLjhGKA==
X-ME-Sender: <xms:vNeZZBT27BMOXD8J3-5bV_K7DCXxccIBF4FLXxxYlh5V_VxCdDLYOQ>
    <xme:vNeZZKzaYNvP7NINEgzCtzP_JRlnEk2ZmYEf4wfvJ-q2MGWUMk1igx47iVb4FKU_l
    a0Xx9KsAmyXsgcD>
X-ME-Received: <xmr:vNeZZG37oyJrwuPwQ9HPu-fEj07IrysWiv8hdDCvsSKiTngmR7CKdBNLf0tKKKGNUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehfedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpefgudevueevveeiudejveeffeejkeegvddu
    heekvdefhfetgeegheekkeetleehgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhn
    ugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhm
X-ME-Proxy: <xmx:vNeZZJBnFaexQnSa9j4JVsTDhwJzn4oyEDAOWsfLgRcvq6XAy2g-FA>
    <xmx:vNeZZKg8LPTgh_5gQ2-Km3Fy0NTN-AusPs36uPN5DqP_4sKpYMp5qQ>
    <xmx:vNeZZNpfG9GZsT3GF7c6X9BDAbZMmoIvrvDSJtjOw7RW1q4FKGZZ-A>
    <xmx:vdeZZCcfho15OIyKs0GDlPGGL-FQLfbBWYWo7aGf_G2n0s476XfZnA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jun 2023 14:23:55 -0400 (EDT)
Message-ID: <7da6719c-23ee-736e-6787-1aad56d22e07@fastmail.fm>
Date:   Mon, 26 Jun 2023 20:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH] fuse: invalidate page cache pages before direct write
Content-Language: en-US
To:     Hao Xu <hao.xu@linux.dev>, fuse-devel@lists.sourceforge.net
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
References: <20230509080128.457489-1-hao.xu@linux.dev>
 <0625d0cb-2a65-ffae-b072-e14a3f6c7571@linux.dev>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <0625d0cb-2a65-ffae-b072-e14a3f6c7571@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 6/8/23 09:17, Hao Xu wrote:
> Ping...
> 
> On 5/9/23 16:01, Hao Xu wrote:
>> From: Hao Xu <howeyxu@tencent.com>
>>
>> In FOPEN_DIRECT_IO, page cache may still be there for a file, direct
>> write should respect that and invalidate the corresponding pages so
>> that page cache readers don't get stale data. Another thing this patch
>> does is flush related pages to avoid its loss.
>>
>> Signed-off-by: Hao Xu <howeyxu@tencent.com>
>> ---
>>
>> Reference:
>> https://lore.kernel.org/linux-fsdevel/ee8380b3-683f-c526-5f10-1ce2ee6f79ad@linux.dev/#:~:text=I%20think%20this%20problem%20exists%20before%20this%20patchset
>>
>>   fs/fuse/file.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 89d97f6188e0..edc84c1dfc5c 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1490,7 +1490,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, 
>> struct iov_iter *iter,
>>       int write = flags & FUSE_DIO_WRITE;
>>       int cuse = flags & FUSE_DIO_CUSE;
>>       struct file *file = io->iocb->ki_filp;
>> -    struct inode *inode = file->f_mapping->host;
>> +    struct address_space *mapping = file->f_mapping;
>> +    struct inode *inode = mapping->host;
>>       struct fuse_file *ff = file->private_data;
>>       struct fuse_conn *fc = ff->fm->fc;
>>       size_t nmax = write ? fc->max_write : fc->max_read;
>> @@ -1516,6 +1517,17 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, 
>> struct iov_iter *iter,
>>               inode_unlock(inode);
>>       }
>> +    res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
>> +    if (res)
>> +        return res;
>> +
>> +    if (write) {
>> +        if (invalidate_inode_pages2_range(mapping,
>> +                idx_from, idx_to)) {
>> +            return -ENOTBLK;
>> +        }
>> +    }
>> +
>>       io->should_dirty = !write && user_backed_iter(iter);
>>       while (count) {
>>           ssize_t nres;
> 

Is this part not working?

	if (!cuse && fuse_range_is_writeback(inode, idx_from, idx_to)) {
		if (!write)
			inode_lock(inode);
		fuse_sync_writes(inode);
		if (!write)
			inode_unlock(inode);
	}



Thanks,
Bernd
