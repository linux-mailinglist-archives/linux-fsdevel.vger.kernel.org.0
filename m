Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B095785580
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjHWKgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjHWKgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:36:05 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5430CE46;
        Wed, 23 Aug 2023 03:35:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E5735C00DE;
        Wed, 23 Aug 2023 06:35:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 23 Aug 2023 06:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692786948; x=1692873348; bh=oSYs/vkLjyBO5XlBO2MdH1veNO85674mMk1
        aIBQ7n/Q=; b=G2ToborH/0dndh9CdhHciY57dwM8XyNU6sHUEeg/yLjum05hSbj
        oLgJ7uTavmUbwD/KMiW8zeSVyII7F822N29wuioTUAOFcdj/f0m58hhDRE4t19XF
        2KBc4t0ebB3L6Hb5D63BtjfI8ddiGuC9nCqapk0vkrIzYYZhzsSGzG2rV7nxTviq
        clrpkS34HDklHFfnSwOGpURTFkkZwbSK2ghaXBSl+UnZ96h9uBPe58EzqNb+hEsu
        2iyfHVw1eJwGSz3y/oJb65E2DkARfTJh0DFR5qN4TBmkHL3WgPf6FqCScmEQaYJB
        HPKaNaQrxfZdFnMWRbNvrea/EWORwbbyVYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692786948; x=1692873348; bh=oSYs/vkLjyBO5XlBO2MdH1veNO85674mMk1
        aIBQ7n/Q=; b=k/JCpqt59Pz9EYR6jQy1UHA4TwRQwIaqFcy/4wHnfsNOMEUXn3q
        uvIIyePAtW0S31qiDXO1LoajO/MLuiQR7P2nxgCxHSUVUZjXSwlWtb+wn3DEDnp5
        zIVlV0Im+C+7OKuHUA6HKHi53/QWKXV7MDaIzjeEI6OCMp7BvLJhl5GN7MGLsNZI
        wBAWhO7g4v+jPde2C1gHw1GVUUSny47o9TbxsqkzN6/gE/ltdyzU3gtoTvtn1oB+
        Qy28WXacFZB/9+EXjBeaMaqddrbf3F8nWTHpw4QK/LVMpm2GnJDJI3tRKjXUnIwH
        zzzsZ5Uie/HVk2iPw88Qna3U8L/uW49QV7Q==
X-ME-Sender: <xms:AuHlZFkaG6y1zAZTnSdbZD3m9lkf39MUo3y8QAuIG2L5qD9sQGH2Nw>
    <xme:AuHlZA1KOGHYT7UYZdckBGbPEUZq1lnrlOIFlAlgopx9e4RbW4iQsrbTilCmW5OTd
    oQ67zPNo7Q5pv9F>
X-ME-Received: <xmr:AuHlZLqN23gnhX9G9VMJ4obtxKsUV1cwD6hu9zra6GGf-FRUEb5jVfJfxgwIruGk-B1gwUuKF1jamfHaZLy2ba0eZMV0h5hW0bUid3QhQN7aCtuUyBVO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:A-HlZFngK--R-CmuZkT0s7MHyPAFK7gx7o_k_M2tNmeem4Wzr2vOlg>
    <xmx:A-HlZD1Ajn3mkZhd7cfnt_E9rMu10NkBERhBo4b7T9NuxVgjt25Rkw>
    <xmx:A-HlZEvEauLDyZ0eV8eoylN4SuqOn0Qdn6WDp7h0ItrnR2gncEHClw>
    <xmx:BOHlZD-yvfIWm6Z8KTnx4zt4xP090HAmZ-6XfwxbvLhTaDYNq4sj3w>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 06:35:45 -0400 (EDT)
Message-ID: <699673a6-ff82-8968-6310-9a0b1c429be3@fastmail.fm>
Date:   Wed, 23 Aug 2023 12:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] fuse: writeback_cache consistency enhancement
 (writeback_cache_v2)
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@jcix.top
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
 <20230711043405.66256-5-zhangjiachen.jaycee@bytedance.com>
 <CAJfpegtqJo78wqT0EY0=1xfoSROsJogg9BNC_xJv6id9J1Oa+g@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegtqJo78wqT0EY0=1xfoSROsJogg9BNC_xJv6id9J1Oa+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/23/23 11:07, Miklos Szeredi wrote:
> On Tue, 11 Jul 2023 at 06:36, Jiachen Zhang
> <zhangjiachen.jaycee@bytedance.com> wrote:
>>
>> Some users may want both the high performance of the writeback_cahe mode
>> and a little bit more consistency among FUSE mounts. Current
>> writeback_cache mode never updates attributes from server, so can never
>> see the file attributes changed by other FUSE mounts, which means
>> 'zero-consisteny'.
>>
>> This commit introduces writeback_cache_v2 mode, which allows the attributes
>> to be updated from server to kernel when the inode is clean and no
>> writeback is in-progressing. FUSE daemons can select this mode by the
>> FUSE_WRITEBACK_CACHE_V2 init flag.
>>
>> In writeback_cache_v2 mode, the server generates official attributes.
>> Therefore,
>>
>>      1. For the cmtime, the cmtime generated by kernel are just temporary
>>      values that are never flushed to server by fuse_write_inode(), and they
>>      could be eventually updated by the official server cmtime. The
>>      mtime-based revalidation of the fc->auto_inval_data mode is also
>>      skipped, as the kernel-generated temporary cmtime are likely not equal
>>      to the offical server cmtime.
>>
>>      2. For the file size, we expect server updates its file size on
>>      FUSE_WRITEs. So we increase fi->attr_version in fuse_writepage_end() to
>>      check the staleness of the returning file size.
>>
>> Together with FOPEN_INVAL_ATTR, a FUSE daemon is able to implement
>> close-to-open (CTO) consistency like NFS client implementations.
> 
> What I'd prefer is mode similar to NFS: getattr flushes pending writes
> so that server ctime/mtime are always in sync with client.  FUSE
> probably should have done that from the beginning, but at that time I
> wasn't aware of the NFS solution.


I think it would be good to have flush-on-getattr configurable - systems 
with a distributed lock manager (DLM) and notifications from 
server/daemon to kernel should not need it.


Thanks,
Bernd
