Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1107863C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 00:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbjHWW4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 18:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjHWWzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:55:38 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B78E50;
        Wed, 23 Aug 2023 15:55:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 09BFF5C01AD;
        Wed, 23 Aug 2023 18:55:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 23 Aug 2023 18:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692831334; x=1692917734; bh=Am3NaVWh1u/SgUw7D2u+AYl0pmbKqJ0ODUQ
        Srt76FLw=; b=YB0nxz8sKG1HPYZ65G22dhh+G104mMsVpx3YCbl29nFeVSwgSpa
        4vBKAWSk5hmSTktXkvmmzpZo1UJh9ZY/jWZh8sWwFPiGrdpwQI4iGDT/LCroJA5i
        SAsnmzBYyZayRGZ3itMRoCEzI/uvx77YrdM8GwcmbnuLp8zCVkz/XlFk0HV97TKc
        hHoxUGfJA0OP1a8rxrsPG/iCg6WWl1EirDxap4lBZoG16bUOyuN5F37ov2grhR04
        0K36nkN2F4mAhlh7vcGVLMUk4ZY5yTQ+ckHcLNtHWtyYm5UmnFKSg2ZrwzOkFXdW
        19TkykbggkYyWVo4As/JKIext1/EdFyZF7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692831334; x=1692917734; bh=Am3NaVWh1u/SgUw7D2u+AYl0pmbKqJ0ODUQ
        Srt76FLw=; b=G2WqtEH5Bme/lGj/cbwwRqfJNPMkhQT/2FU/2g9FNMgk3UsxGS+
        Qw70Mn5889ecllLcQNaNcnVLqarP+8OsWHXYL8bb656SMOSZEZNu5ade1pa9d7PB
        3D3t9+yY1YMrMSp9QQLXzHfsc1FfE8+o6hue+rl7aJbfaEKz1DVNOxknUCOREvZu
        ixRCaS+ICxmMdurKtCX+b3zO1VVSqGFzY/Q82pj0WFh2D0kr0TJZYSixu1vMa3BY
        7z8SymN7IH8tkaYcX5EGkDp/1YNJXlAFtRVUzFjmglSBiC2gR6nk+mVyYn+JMoa5
        PuIW+c9W8W6nEUj/utGsFOB+zPX+eMnythA==
X-ME-Sender: <xms:ZI7mZPdVTaEZHAeSusAr0CdEjYK9W3iDkbel76QFCgveTkzOxMlpGw>
    <xme:ZI7mZFOg0-IXeDFuB_sHvCkLAAY8UCBraoSx8A8YFFQQFCaXkDSSenEbw9mWKtcGf
    e8KQlwwaYKejdQ0>
X-ME-Received: <xmr:ZI7mZIgtCnSinPCSrqpD9fhuCyc5c7GzCDJQW1WNHpDsH7Ad5uHrWNhRvFpbdZh6ZftH81z-hDwZB_AlsC2Hy-r5-Hskn65YAmKi-gu4wxvOgy2fp7tG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvhedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepfffhtddvveeivdduuedujeetffekkeelgfdv
    fefgueffieefjefgjeffhedttdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:ZI7mZA__gLvDsrZi6XdmTCmlsG_kXF1kcP13MCbW2AutxMaEVLYRpw>
    <xmx:ZI7mZLvXKxuKfb8m8kBd-UFIYUY5nuR7yGjyBHE8wYYnmPgMCBanMg>
    <xmx:ZI7mZPF4x4AgUbwQTTFGjme2CnGNKVbCCSrdc3GIQUiGyTHCHlBhJA>
    <xmx:Zo7mZBVzzL9BfCCAzBMOsYVYjB82LOwcT1p2YaCTqFgl5tMeMtWr8A>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 18:55:31 -0400 (EDT)
Message-ID: <38a74f67-9bfc-6cb6-6999-343aac95b781@fastmail.fm>
Date:   Thu, 24 Aug 2023 00:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] fuse: writeback_cache consistency enhancement
 (writeback_cache_v2)
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@jcix.top
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
 <20230711043405.66256-5-zhangjiachen.jaycee@bytedance.com>
 <CAJfpegtqJo78wqT0EY0=1xfoSROsJogg9BNC_xJv6id9J1Oa+g@mail.gmail.com>
 <699673a6-ff82-8968-6310-9a0b1c429be3@fastmail.fm>
 <029cb695-9b8e-8fb3-ef0f-b223f34e7639@bytedance.com>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <029cb695-9b8e-8fb3-ef0f-b223f34e7639@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/23/23 12:59, Jiachen Zhang wrote:
> On 2023/8/23 18:35, Bernd Schubert wrote:
>> On 8/23/23 11:07, Miklos Szeredi wrote:
>>> On Tue, 11 Jul 2023 at 06:36, Jiachen Zhang
>>> <zhangjiachen.jaycee@bytedance.com> wrote:
>>>>
>>>> Some users may want both the high performance of the writeback_cahe 
>>>> mode
>>>> and a little bit more consistency among FUSE mounts. Current
>>>> writeback_cache mode never updates attributes from server, so can never
>>>> see the file attributes changed by other FUSE mounts, which means
>>>> 'zero-consisteny'.
>>>>
>>>> This commit introduces writeback_cache_v2 mode, which allows the 
>>>> attributes
>>>> to be updated from server to kernel when the inode is clean and no
>>>> writeback is in-progressing. FUSE daemons can select this mode by the
>>>> FUSE_WRITEBACK_CACHE_V2 init flag.
>>>>
>>>> In writeback_cache_v2 mode, the server generates official attributes.
>>>> Therefore,
>>>>
>>>>      1. For the cmtime, the cmtime generated by kernel are just 
>>>> temporary
>>>>      values that are never flushed to server by fuse_write_inode(), 
>>>> and they
>>>>      could be eventually updated by the official server cmtime. The
>>>>      mtime-based revalidation of the fc->auto_inval_data mode is also
>>>>      skipped, as the kernel-generated temporary cmtime are likely 
>>>> not equal
>>>>      to the offical server cmtime.
>>>>
>>>>      2. For the file size, we expect server updates its file size on
>>>>      FUSE_WRITEs. So we increase fi->attr_version in 
>>>> fuse_writepage_end() to
>>>>      check the staleness of the returning file size.
>>>>
>>>> Together with FOPEN_INVAL_ATTR, a FUSE daemon is able to implement
>>>> close-to-open (CTO) consistency like NFS client implementations.
>>>
>>> What I'd prefer is mode similar to NFS: getattr flushes pending writes
>>> so that server ctime/mtime are always in sync with client.  FUSE
>>> probably should have done that from the beginning, but at that time I
>>> wasn't aware of the NFS solution.
>>
>>
>> I think it would be good to have flush-on-getattr configurable - 
>> systems with a distributed lock manager (DLM) and notifications from 
>> server/daemon to kernel should not need it.
>>
>>
>> Thanks,
>> Bernd
> 
> Hi Miklos and Bernd,
> 
> I agree that flush-on-getattr is a good solution to keep the c/mtime
> consistency for the view of userspace applications.
> 
> Maybe in the next version, we can add the flush-on-getattr just for the
> writeback_cache_v2 mode, as daemons replying on reverse notifications
> are likely not need the writeback_cache_v2 mode. What do you think?

Hi Jiachen,

isn't Miklos' idea that we can avoid writeback_cache_v2 mode?


Thanks,
Bernd
