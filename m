Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791CC5BC370
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 09:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiISHQx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 03:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiISHQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:16:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA36813F79
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 00:16:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3E99B5C00E3;
        Mon, 19 Sep 2022 03:16:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 19 Sep 2022 03:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1663571807; x=
        1663658207; bh=buMdk1LuVyhlw+LLoUR1/6ypooGKfS+JAhcoxno57X4=; b=S
        X5yxoAxFh9S2Fk7IxO1jBSpCKRifv9wh9nj655Mr7+KbsrDuIpvwTskpDzRyHKQ6
        G9Rnfc7EtULYbS/mQMeusY36YWGiL8taVvejr86B+9+AlPaCoSQnD8ijXohXMbbn
        pMZpVfTzTKY6HWEy2L/k6G4TXBXWaci1zPExn412yXGHD25pfzz2hTvZNauvp/nF
        mPTecI+z0VbYlL1U6usfM+YV8VcQqnX4/0OFn0XSBoOKJu3t+QS66C/GlnnJvuHx
        Qqmop9fkQFlok+k/MttnNbbWoENUAOTr4/yfKb4daQZOpyzzhYeLTZDFjW8CCRvi
        zmJj8yy2OTOJElpJxADPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663571807; x=
        1663658207; bh=buMdk1LuVyhlw+LLoUR1/6ypooGKfS+JAhcoxno57X4=; b=T
        5pJV+oC8gWNSqh27xlGlLsE8vAessHbpvSUac74dPQLMQ5Iq4PXe9AMbBzQtCBaf
        mjHtXUuKn9aVJq625heMUdHhUv6xCLvt+TOk995GgOiHAV4ZknXLJ15ApFchLdqU
        cx1nPkYsajoBGpm+TQ4LcL5jrgRISZBsKOYnt+PWNwP/H5wK6xGUuSkVbLRToO7u
        2jOPkTf1iPxG3Q1gwzatx9tg+RqWUwvWvQ9nJWAkdgBk4XqX2LxKgAA7bTt3TAiQ
        XJYuQDX6qpgW1l+joZL8M+HA+OVAMEoJ1ChxwmBiEa3pVviaMPwcIElFZKgvP2gg
        +GBIcC7hRY898iI0BOmwQ==
X-ME-Sender: <xms:XhcoY72fVxcw6Ynq_wgSegLREpdkN0XJM9tbCSgDBbHVjBqaXhNcGA>
    <xme:XhcoY6HtBBpqizLoSXJhZMzFO6y5fPZE1YWsjg-tlIO-3zn3HLQ51Wpuhfg7iwxjB
    TcmYJv1Uicmc69z>
X-ME-Received: <xmr:XhcoY74rZCeeGhgZABTHfdWv_MEHWi45iVmwaIr6NXYkeNbRsKB5fAy_MW4lCY9f92FTG6cc92bfR_eAP87PceXKcBB861t_80HEmuDZXYWN82FHRLA->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedviedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekheevkeelkeekjefhheegfedtffduudej
    jeeiheehudeuleelgefhueekfeevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:XhcoYw3A_iD2govH7HQwqGbivKIhJZwNRLbyDz6eUAZ8l84_5-w0lQ>
    <xmx:XhcoY-E3Q3umgx--HFpMxmk6D8Bns7yM-Ht-tQDD4HvE7ql9RGmeDg>
    <xmx:XhcoYx-NJQJdHStg40_2C0-Y0Spb0ZFz7ZbpvaotQ-35OUOGCL4sQw>
    <xmx:XxcoYz5ukIlrelpF-7BfJSQkdYTmGbKpLaU9JQMKk-RxH9Nag0G1Ng>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Sep 2022 03:16:46 -0400 (EDT)
Message-ID: <d3cf2868-aacb-1146-8027-b22d6007e293@fastmail.fm>
Date:   Mon, 19 Sep 2022 09:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 8/8] fuse: implement ->tmpfile()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
References: <20220916194416.1657716-1-mszeredi@redhat.com>
 <20220916194416.1657716-8-mszeredi@redhat.com>
 <66d2c136-547a-3538-d015-c4ee0dcb2419@fastmail.fm>
 <CAJfpegtk8HPFfQegrs1fsPuC3hwHD2TXvGS7pQor=EoqMmtfng@mail.gmail.com>
Content-Language: de-CH, en-US
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegtk8HPFfQegrs1fsPuC3hwHD2TXvGS7pQor=EoqMmtfng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/19/22 08:30, Miklos Szeredi wrote:
> On Fri, 16 Sept 2022 at 23:52, Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 9/16/22 21:44, Miklos Szeredi wrote:
>>
>>
>>> +static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
>>> +                     struct file *file, umode_t mode)
>>> +{
>>> +     struct fuse_conn *fc = get_fuse_conn(dir);
>>> +     int err;
>>> +
>>> +     if (fc->no_tmpfile)
>>> +             goto no_tmpfile;
>>> +
>>> +     err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
>>> +     if (err == -ENOSYS) {
>>> +             fc->no_tmpfile = 1;
>>> +no_tmpfile:
>>> +             err = -EOPNOTSUPP;
>>> +     }
>>> +     return err;
>>> +}
>>
>> A bit confusing part is that the other file systems are calling your new
>> finish_tmpfile(), while fuse_create_open() calls finish_open() for
>> tmpfiles as well. Seems to be identical but won't this easily miss
>> possible changes done in the future to finish_tmpfile()?
> 
> There shouldn't be any such changes.  It's really just a shorthand
> form of finish_open().

It is just a minor concern for future maintenance, from my point of view 
it is better to be entirely consistent.

> 
> Would calling it finish_open_simple() help?   It really has nothing to
> do with tmpfile and .atomic_open instances could call it as well.

Yeah, I think that would be a better name, maybe others could add their 
opinion here?


Thanks,
Bernd
