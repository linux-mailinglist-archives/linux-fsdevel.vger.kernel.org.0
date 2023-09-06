Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01327793F87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbjIFOvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 10:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242011AbjIFOvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:51:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068DD173D;
        Wed,  6 Sep 2023 07:51:28 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D2A735C00A9;
        Wed,  6 Sep 2023 10:51:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 06 Sep 2023 10:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694011884; x=1694098284; bh=+brk3DBvQctuRhh5s5vzTt3UlzYUwvCsQUF
        c4nl3OTk=; b=K3UvSUXJMnEC6cSA1Z037hj8BJqypUiBAIyUHKWJKka2IU5nPxA
        lBmt37in8TwlUGqfgZp31X9K+yPW8K6gUGVA36gV0WDdTdIEwK/rSZbqk3/zFOO0
        zQfaTeIWvFlQZ5NWWL6c+Ns3PHBShJMv/Hk625Xl3mXmJGFWhXsn/9OvEGQsbX18
        5dCv8q1fboaJenNWd5qw/HfIWysJZfuqEUzZO1061RLDItsG8F3j6zzhZwNrWIIj
        rLLx3SQeHWeN9jjt4XR1QOfPnReLtHp5I0L+eH3A1YVI2u3AO1rMQux2UIvB57jB
        sWMfjEqNiTnEPkYNXmGj7Mhn2xcAyVbvAuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694011884; x=1694098284; bh=+brk3DBvQctuRhh5s5vzTt3UlzYUwvCsQUF
        c4nl3OTk=; b=IAhK/P4v28W6TxbChcUxqw4QXHhjAXOVsBUy5O+7wcsH+th4KE3
        Z5pKXYgVBpDWFy0vRRUgk6Iki9a+jWZMCth4Aw/zCjGrdYA9udrREsNXzdw4IUsR
        BLArthPCp4V8ogH0V5u2toBfOvAwDQWGhTkvEiIGxRs07rXsYbwciVXPYyMxXawi
        RXuhmPlISd6dKu4KUaHMoMd/jS/Z1pvV0Azcsb3RQ+WSduU/eog+f3/Ja3C81I74
        1Th6vWEsqA+ZCuc4ioWsSrj/QqojGJy3rQZREClahk10HBBE5clbCqcvt8dc8wcM
        aXrbWgduJsodkq+0uBW8OCHFzufxrU5EDtg==
X-ME-Sender: <xms:65H4ZOQyY4UoniUtoMIVFYP5Mw9CZm5IgRccuXORT3hMS0iI0OJY5Q>
    <xme:65H4ZDyfG9VE1SEjhVmpBic2O2Q7c95-ww_5BgjRkbVmZlRG1ySL_5We-ykJGvfo9
    3hdYnFJ8tF8Db-g>
X-ME-Received: <xmr:65H4ZL0Mg1gPOWv0Z27cpFXVR4iYTaGJsoXAlkK8-9cPEnwkICAogXd7NQc21hSZE_BLRFrkBRHkWsImu-ClzX_Ejaf4F0Z-Px_C_n0zESUNUuKit1sf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:65H4ZKCmXVb9I-xlCxc1XL_5qJlgFf7ddtXkEwaF0vQCqlUHTUfdNw>
    <xmx:65H4ZHh2V4HiFkVOTuDkw7lUb58REkHW8tiHh63xqnjadPhMpyMXeQ>
    <xmx:65H4ZGrdM25UHJJnIA_xDS7BP-6dl2EJo-_87Y8jaGr4dFXftmOYiw>
    <xmx:7JH4ZHhw2-yNXd_MLf6vBd9j4NNUXrWsxHuxo1xPgSBWU5N3XMxR0w>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Sep 2023 10:51:22 -0400 (EDT)
Message-ID: <30b8c2b6-1ce2-cef1-0d65-dc12787c9294@fastmail.fm>
Date:   Wed, 6 Sep 2023 16:51:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 0/2] Use exclusive lock for file_remove_privs
Content-Language: en-US, de-DE
To:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20230831112431.2998368-1-bschubert@ddn.com>
 <20230905180259.GG14420@twin.jikos.cz>
 <20230906-teeservice-erbfolge-a23bfa3180eb@brauner>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <20230906-teeservice-erbfolge-a23bfa3180eb@brauner>
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



On 9/6/23 16:43, Christian Brauner wrote:
> On Tue, Sep 05, 2023 at 08:02:59PM +0200, David Sterba wrote:
>> On Thu, Aug 31, 2023 at 01:24:29PM +0200, Bernd Schubert wrote:
>>> While adding shared direct IO write locks to fuse Miklos noticed
>>> that file_remove_privs() needs an exclusive lock. I then
>>> noticed that btrfs actually has the same issue as I had in my patch,
>>> it was calling into that function with a shared lock.
>>> This series adds a new exported function file_needs_remove_privs(),
>>> which used by the follow up btrfs patch and will be used by the
>>> DIO code path in fuse as well. If that function returns any mask
>>> the shared lock needs to be dropped and replaced by the exclusive
>>> variant.
>>>
>>> Note: Compilation tested only.
>>
>> The fix makes sense, there should be no noticeable performance impact,
>> basically the same check is done in the newly exported helper for the
>> IS_NOSEC bit.  I can give it a test locally for the default case, I'm
>> not sure if we have specific tests for the security layers in fstests.
>>
>> Regarding merge, I can take the two patches via btrfs tree or can wait
>> until the export is present in Linus' tree in case FUSE needs it
>> independently.
> 
> Both fuse and btrfs need it afaict. We can grab it and provide a tag
> post -rc1? Whatever works best.

fuse will need it for my direct IO patches - hopefully in 6.7.
For btrfs it is a bug fix, should go in asap?

Christoph has some objections for to use the new exported helper
(file_needs_remove_privs). Maybe I better send a version for btrfs
that only uses S_NOSEC? For fuse we cannot use it, unfortunately.


Thanks,
Bernd
