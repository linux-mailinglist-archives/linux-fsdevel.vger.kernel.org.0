Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7521378EF6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 16:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbjHaORO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 10:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjHaORN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:17:13 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44CBCF;
        Thu, 31 Aug 2023 07:17:06 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1BE325C00E2;
        Thu, 31 Aug 2023 10:17:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 31 Aug 2023 10:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1693491426; x=1693577826; bh=ujBGhyhAt9A8hQUJddVzAjIRR29GE6IRQ6g
        2wif/pL4=; b=LdFZzrqvYgQoom2bVXh8spsMZACL3YcIBnxs7RUhQn/vbpy3y+S
        FcfiMtl6VyU8mGxqGwnMxTSgr1r4vjcqXbtlk2WhHL2bGLeTe5LAAWOYSnLIwtaH
        Pudr1yuGk5n7AQkvDFyIkCBgPLrul6HuyYDLaOHj8Eyuwo0jyCSfXHvKUQ3Aw/JM
        x8hpbvufU8PAiiCRabaydvFpWLqt0FIATXsSKzfE5vom1MKjnQwqU0r0/LGUT2EA
        hHHNzot2vvayYjWHyKZGeHQdrkOwgWPXoR62+IGjgfH3aMM22LSgfw7gWacLataw
        c4qNteY1hDthmb/DQQg4AKhZgWSrnHoXUZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1693491426; x=1693577826; bh=ujBGhyhAt9A8hQUJddVzAjIRR29GE6IRQ6g
        2wif/pL4=; b=reSfwTuvMBYHT4M91/Q30vNWXUyJj5sUmNLIn04K9OqJPaoNtvU
        JLDKzmazzvNAowIaH2zw0iNBz+tneDrPFz5VBAnOS77dqGIhXi8crH3Z2YwU+VY3
        UfvMLid8+tLm25Xp7rDkytvheuJ/pJQMh47KPtTwb153SsLfISFWPjnvptX4Kl4X
        frA49vMQk1ic+00eUY05ROApcdBg5myqXkkY7d5LWoSIhFrO1v48lBKR/lmSlSn+
        OFvLwVBQDXYAIwNdb0OGkFcviLm/C3QNGuXQkwm7Pn01apk5iX0BqOI/9eUgDIvY
        1v24pHBddSOs8eubm/LCFakc01xjMf7y4cw==
X-ME-Sender: <xms:4aDwZOvBoOC1TRdyUNl-cjohmHhRtBatHCKYdHo7MRvVv15fJQ-Rqg>
    <xme:4aDwZDfPRentEcW0fnWplR6DWH-QrvjJhwpfhlYnmyMG77-Cv6EhwotvQ6XjSUx6A
    uQvuz2iXvBIKh5A>
X-ME-Received: <xmr:4aDwZJz8-Lp05ULMBNBMJ97qWQYgfU9UPi70eP28x1fI65X_aKg8V_tHQWnjcyS3q7jmmGYKj1CR54rHd24HxppF8aca-8peNSYjZ6ngsW8xCrePq2BX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:4aDwZJMiq7uA6vHBh_9Vlf6gZsm373tR4LneFkisdmM4AM7T1RbynQ>
    <xmx:4aDwZO-OtT6rb_ewUfnz45nirZF-ao0hWieh_DyOBTuPWuyRvaavVQ>
    <xmx:4aDwZBUy81hc973LTBlL16HjBeus9dRTWci32rpBEhsks2uF0V6NTA>
    <xmx:4qDwZOx3PvTsf3rRxK6UmJFZAtrAL8X_sLSb3CskQ06Yw_cpARP1UA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Aug 2023 10:17:04 -0400 (EDT)
Message-ID: <99bc64c2-44e2-5000-45b7-d9343bcc8fb8@fastmail.fm>
Date:   Thu, 31 Aug 2023 16:17:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] fs: Add and export file_needs_remove_privs
To:     Christian Brauner <brauner@kernel.org>,
        Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20230831112431.2998368-1-bschubert@ddn.com>
 <20230831112431.2998368-2-bschubert@ddn.com>
 <20230831-letzlich-eruption-9187c3adaca6@brauner>
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230831-letzlich-eruption-9187c3adaca6@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/31/23 15:40, Christian Brauner wrote:
> On Thu, Aug 31, 2023 at 01:24:30PM +0200, Bernd Schubert wrote:
>> File systems want to hold a shared lock for DIO writes,
>> but may need to drop file priveliges - that a requires an
>> exclusive lock. The new export function file_needs_remove_privs()
>> is added in order to first check if that is needed.
>>
>> Cc: Miklos Szeredi <miklos@szeredi.hu>
>> Cc: Dharmendra Singh <dsingh@ddn.com>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Cc: linux-btrfs@vger.kernel.org
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: linux-fsdevel@vger.kernel.org
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>   fs/inode.c         | 8 ++++++++
>>   include/linux/fs.h | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/fs/inode.c b/fs/inode.c
>> index 67611a360031..9b05db602e41 100644
>> --- a/fs/inode.c
>> +++ b/fs/inode.c
>> @@ -2013,6 +2013,14 @@ int dentry_needs_remove_privs(struct mnt_idmap *idmap,
>>   	return mask;
>>   }
>>   
>> +int file_needs_remove_privs(struct file *file)
>> +{
>> +	struct dentry *dentry = file_dentry(file);
>> +
>> +	return dentry_needs_remove_privs(file_mnt_idmap(file), dentry);
> 
> Ugh, I wanted to propose to get rid of this dentry dance but I propsed
> that before and remembered it's because of __vfs_getxattr() which is
> called from the capability security hook that we need it...

Is there anything specific you are suggesting?

And thanks for typo/grammar annotations, I'm going to wait for btrfs 
feedback before I'm going to send a new version.


Thanks,
Bernd
