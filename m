Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA00794046
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbjIFPXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjIFPXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:23:49 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C549D172C;
        Wed,  6 Sep 2023 08:23:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E2B15C01B5;
        Wed,  6 Sep 2023 11:23:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 06 Sep 2023 11:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694013825; x=1694100225; bh=U1O/y0QDcTrLAYLcVNVYUrsxfMF7TRIG9SX
        zqupPaGE=; b=daUzH/0cNzXT88KBnDRo9bYsWPmGYsqUXgu0xSFSBR0Exbh9lg0
        fbtvfw8k640FGMQcP1+1Py2dhTyZBqrWirRX2BwT0/eb4bcDAKjq/7NTipJdBm8I
        OmgQUU2uA9qzOT3Lv24rbnffY9ki200SQJ+JRzsKtRn0dcM+308VYcqgL8pPs/Va
        KRzWaV83I/EcuYBajzNIuDzbEtSJGPcucmhWgzeWG1tHiIO0jhhdBgp0kigU8/RZ
        qCHsZblixwV/Vyqa8ZT6+B7QrIA1/Tr1vocJAROQnd2Y9TaI6LyoskLrbBfExc+H
        XSmAnOLxKhFmvGBiX+B5/zY8mIT17L0qL2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694013825; x=1694100225; bh=U1O/y0QDcTrLAYLcVNVYUrsxfMF7TRIG9SX
        zqupPaGE=; b=dqVz8P3KP0xR9pitIZuY5sm18x0LuDjtTV+9T6atiwj+WsXdw5q
        nzaThYYspi2l4qyYHc1e3rrvsKyIG9O3712da2WqqvJmkfwikocmGwdwIbXcorhg
        BcuRnb24dFRh1rhs6d/e0fOdKPcYNkUQz6hv9/zRK6SmCysotmlCbx3e0EUw1cUS
        7U1iaC2/zWWSk5PbvYzJRomEtODrhKbco+PWMlMMWlLP1MgE3VcpiSZiYy8rKM+O
        wKAQoyw7LLV+1lwzBpmOAXxVqVwLZ5aGlxwwibpP6BTR9BiB8ZlD7BHZ1p0ALuOi
        cO8ug6bLXoyu8jrBSkQb2mOxUXn2k4iotVA==
X-ME-Sender: <xms:gJn4ZKVUwaMbNHpwyKbZlPbjnNjCNeWcF0vwm4wyk9OA-eGJvUW6Pg>
    <xme:gJn4ZGlkb9FZrwZu6g2bUMlPVNNH5Ym-89hMS-L14Yngh5auLzJIcB3kAHf5ptoQx
    yGrWSv5SjpENddq>
X-ME-Received: <xmr:gJn4ZOZu0NY0DqBgu4to2aubpBbAM3D3llea_F7W21iZt5MNAiqclr3BkGLNlRvnPKd7CJ2NfD-C0mCOj4ZNyvGMamjNJuq2UJDpO-y_d7bMFCzHCJ7V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:gZn4ZBVITa9mzDjVh7_OfkX2T8vuz1iNDhGRvjEIdrz6ZEK_g8PVfA>
    <xmx:gZn4ZElTSvgzJqaHfwBDdWi60hcrxskYJ_WoWb-pYrwv1i9XuJaxsg>
    <xmx:gZn4ZGeoqxTLuxcFsxuGhdzikuG77GhNNDt339DbByzIIXI2b8Zz0Q>
    <xmx:gZn4ZFCJUuIVO7qnpshzOHY0rCyiiz1AcMpedShGIXpI_KpQwqJSJQ>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 11:23:44 -0400 (EDT)
Message-ID: <b0434328-01f9-dc5c-fe25-4a249130a81d@fastmail.fm>
Date:   Wed, 6 Sep 2023 17:23:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Content-Language: en-US, de-DE
To:     Matthew Wilcox <willy@infradead.org>,
        Mateusz Guzik <mjguzik@gmail.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230831151414.2714750-1-mjguzik@gmail.com>
 <ZPiYp+t6JTUscc81@casper.infradead.org>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <ZPiYp+t6JTUscc81@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/6/23 17:20, Matthew Wilcox wrote:
> On Thu, Aug 31, 2023 at 05:14:14PM +0200, Mateusz Guzik wrote:
>> +++ b/include/linux/fs.h
>> @@ -842,6 +842,16 @@ static inline void inode_lock_shared_nested(struct inode *inode, unsigned subcla
>>   	down_read_nested(&inode->i_rwsem, subclass);
>>   }
>>   
>> +static inline void inode_assert_locked(struct inode *inode)
>> +{
>> +	lockdep_assert_held(&inode->i_rwsem);
>> +}
>> +
>> +static inline void inode_assert_write_locked(struct inode *inode)
>> +{
>> +	lockdep_assert_held_write(&inode->i_rwsem);
>> +}
> 
> This mirrors what we have in mm, but it's only going to trigger on
> builds that have lockdep enabled.  Lockdep is very expensive; it
> easily doubles the time it takes to run xfstests on my laptop, so
> I don't generally enable it.  So what we also have in MM is:
> 
> static inline void mmap_assert_write_locked(struct mm_struct *mm)
> {
>          lockdep_assert_held_write(&mm->mmap_lock);
>          VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
> }
> 
> Now if you have lockdep enabled, you get the lockdep check which
> gives you all the lovely lockdep information, but if you don't, you
> at least get the cheap check that someone is holding the lock at all.
> 
> ie I would make this:
> 
> +static inline void inode_assert_write_locked(struct inode *inode)
> +{
> +	lockdep_assert_held_write(&inode->i_rwsem);
> +	WARN_ON_ONCE(!inode_is_locked(inode));
> +}
> 
> Maybe the locking people could give us a rwsem_is_write_locked()
> predicate, but until then, this is the best solution we came up with.


Which is exactly what I had suggested in the other thread :)
