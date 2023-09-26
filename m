Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E2C7AE645
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 08:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjIZGxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 02:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjIZGxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:53:34 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DE1C0;
        Mon, 25 Sep 2023 23:53:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D70DE3200924;
        Tue, 26 Sep 2023 02:53:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 26 Sep 2023 02:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1695711204; x=1695797604; bh=w3s0Dgf7ZNU4pBcYrLEoMk5BLPpr5HzYEj0
        tCtnwHL8=; b=OrwFaHnR2huHzqN5M4cGl/q50k0Gaiux+4hfqK1Cwn6/S2KepeY
        i1BG4GMVMNKA5S8r5WcDW0qNBqSDyPlOiM8OCnQLLBuWB2taDL/F74y34rVyYmsB
        DSgKnbYSLY6FbfCXmE6ZD2UMiberXIZ61hIPc7GMKx8ZKfPmbfFyOSMMuQDUHVCC
        vEOms7YGCq0WVfApCfCmFe0Ls6qiL1odznLjPGxxvQ9JEDL+ROyI9Z7svycV9el/
        qL8BPYfdHsdxYVvn0VVEP4gQzi4E6oyRA0Zz2lX9ys2Iqu/sAv2dY0CZ4+SnuNID
        46YagPQdbXyZTPMp0JH5SaRAMlKU66hSLDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695711204; x=1695797604; bh=w3s0Dgf7ZNU4pBcYrLEoMk5BLPpr5HzYEj0
        tCtnwHL8=; b=MYJZ/Ih3sT+asgkdHIMNEHof9hdX3Wx2yAiWt362TSlAb4jxsm1
        Ls8gESQ4gjQmDo8/I0AGmnB3qQvwKCQw0u4pAnpcgpqcxEWsEOBTiHB4JPHAUhLB
        4jso48HXyJCzBqVDdxZfnHQF8suqXQrnfrYK/hrU3nspH+BVaUfaV7UyrNEMIg5O
        Jit9b54cGQtlxkkPIxqxHyucaZIh5NRL3/c5qHs4O6+Yh9K3csSUoC4R3G20UwnX
        fEvaa9RkWU6ycnoYGPUTKbq2ulWJechpzIkDnK9xnAUJRNhEPB7P4XQpzb77SLWV
        pHjGxl/9H5YId9mRLLt7W5C8Y7QDX7AZOmg==
X-ME-Sender: <xms:438SZaOHOZSSlqACc77MfMp2Xr4iB-w2m1IxcZ_x-PLSigTLZX3ecw>
    <xme:438SZY9OlXhhzXpTtcB3CkKCt6XhXJLEszRDR5sDbMkh8WfTPpYtr9URnO-Oip1Bu
    y4QsSLK5NO0>
X-ME-Received: <xmr:438SZRRFW-Ehe1nPvslFU8WiIRseQyUT1_VjIC_EVEP4jMcigCDF4ayvJjTZYW0d6-Bi-IkdrpdSjPgAOY5s5LqUcK6yOsy0fR19o7LjBp7PTg_BuS33>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelhedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuhffvvehfjggtgfesthekredttdefjeenucfhrhhomhepkfgr
    nhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeiveelkefgtdegudefudeftdelteejtedvheeuleevvdeluefhuddtieegveelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvg
    hnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:5H8SZavNPz9q496XRpfVZ4grLnuudhBjgqtV4gQ4yM18UUE9w_4afw>
    <xmx:5H8SZSf42WDDVKRnUeEyake-LKX1ckeKNDFPf6jh1VgbuEP4F8fB-g>
    <xmx:5H8SZe1OnCgqVda60C8rlKUvm41eU0LlizqOKDYGni50lo8JdHiONQ>
    <xmx:5H8SZfG-UFE5L2cqBze86flJjdAdYEPp8FuBRDgN4nJvfP808d2oRA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 02:53:21 -0400 (EDT)
Message-ID: <ce5106f6-08ee-43e7-6239-6a46992649d4@themaw.net>
Date:   Tue, 26 Sep 2023 14:53:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] autofs: convert autofs to use the new mount api
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
References: <20230922041215.13675-1-raven@themaw.net>
 <20230922041215.13675-8-raven@themaw.net>
 <20230922-vorbringen-spaghetti-946729122076@brauner>
 <7121dcf7-23fe-07a5-9df4-9ea7af6f5964@themaw.net>
In-Reply-To: <7121dcf7-23fe-07a5-9df4-9ea7af6f5964@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/9/23 21:27, Ian Kent wrote:
> On 22/9/23 19:59, Christian Brauner wrote:
>>> +    fsparam_fd    ("fd", Opt_fd),
>>> +/*
>>> + * Open the fd.  We do it here rather than in get_tree so that it's 
>>> done in the
>>> + * context of the system call that passed the data and not the one 
>>> that
>>> + * triggered the superblock creation, lest the fd gets reassigned.
>>> + */
>>> +static int autofs_parse_fd(struct fs_context *fc, int fd)
>>>   {
>>> +    struct autofs_sb_info *sbi = fc->s_fs_info;
>>>       struct file *pipe;
>>>       int ret;
>>>         pipe = fget(fd);
>>>       if (!pipe) {
>>> -        pr_err("could not open pipe file descriptor\n");
>>> +        errorf(fc, "could not open pipe file descriptor");
>>>           return -EBADF;
>>>       }
>>>         ret = autofs_check_pipe(pipe);
>>>       if (ret < 0) {
>>> -        pr_err("Invalid/unusable pipe\n");
>>> +        errorf(fc, "Invalid/unusable pipe");
>>>           fput(pipe);
>>>           return -EBADF;
>>>       }
>>> +static int autofs_parse_param(struct fs_context *fc, struct 
>>> fs_parameter *param)
>>>   {
>>> +        return autofs_parse_fd(fc, result.int_32);
>> Mah, so there's a difference between the new and the old mount api 
>> that we
>> should probably hide on the VFS level for fsparam_fd. Basically, if 
>> you're
>> coming through the new mount api via fsconfig(FSCONFIG_SET_FD, fd) 
>> then the vfs
>> will have done param->file = fget(fd) for you already so there's no 
>> need to
>> call fget() again. We can just take ownership of the reference that 
>> the vfs
>> took for us.
>>
>> But if we're coming in through the old mount api then we need to call 
>> fget.
>> There's nothing wrong with your code but it doesn't take advantage of 
>> the new
>> mount api which would be unfortunate. So I folded a small extension 
>> into this
>> see [1].
>>
>> There's an unrelated bug in fs_param_is_fd() that I'm also fixing see 
>> [2].
>
> Ok, that's interesting, I'll have a look at these developments tomorrow,
>
> admittedly (obviously) I hadn't looked at the code for some time ...

This code pattern is a bit unusual, it looks a bit untidy to have different

behavior between the two but I expect there was a reason to include the fd

handling and have this small difference anyway ...


In [2] that's a good catch, I certainly was caught by it, ;(


>
>
> Ian
>
>>
>> I've tested both changes with the old and new mount api.
>>
>> [1]:
>> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
>> index 3f2dfed428f9..0477bce7d277 100644
>> --- a/fs/autofs/inode.c
>> +++ b/fs/autofs/inode.c
>> @@ -150,13 +150,20 @@ struct autofs_fs_context {
>>    * context of the system call that passed the data and not the one 
>> that
>>    * triggered the superblock creation, lest the fd gets reassigned.
>>    */
>> -static int autofs_parse_fd(struct fs_context *fc, int fd)
>> +static int autofs_parse_fd(struct fs_context *fc, struct 
>> autofs_sb_info *sbi,
>> +                          struct fs_parameter *param,
>> +                          struct fs_parse_result *result)
>>   {
>> -       struct autofs_sb_info *sbi = fc->s_fs_info;
>>          struct file *pipe;
>>          int ret;
>>
>> -       pipe = fget(fd);
>> +       if (param->type == fs_value_is_file) {
>> +               /* came through the new api */
>> +               pipe = param->file;
>> +               param->file = NULL;
>> +       } else {
>> +               pipe = fget(result->uint_32);
>> +       }
>>          if (!pipe) {
>>                  errorf(fc, "could not open pipe file descriptor");
>>                  return -EBADF;
>> @@ -165,14 +172,15 @@ static int autofs_parse_fd(struct fs_context 
>> *fc, int fd)
>>          ret = autofs_check_pipe(pipe);
>>          if (ret < 0) {
>>                  errorf(fc, "Invalid/unusable pipe");
>> -               fput(pipe);
>> +               if (param->type != fs_value_is_file)
>> +                       fput(pipe);
>>                  return -EBADF;
>>          }
>>
>>          if (sbi->pipe)
>>                  fput(sbi->pipe);
>>
>> -       sbi->pipefd = fd;
>> +       sbi->pipefd = result->uint_32;
>>          sbi->pipe = pipe;
>>
>>          return 0;
>>
>> [2]:
>>  From 2f9171200505c82e744a235c85377e36ed190109 Mon Sep 17 00:00:00 2001
>> From: Christian Brauner <brauner@kernel.org>
>> Date: Fri, 22 Sep 2023 13:49:05 +0200
>> Subject: [PATCH] fsconfig: ensure that dirfd is set to aux
>>
>> The code in fs_param_is_fd() expects param->dirfd to be set to the fd
>> that was used to set param->file to initialize result->uint_32. So make
>> sure it's set so users like autofs using FSCONFIG_SET_FD with the new
>> mount api can rely on this to be set to the correct value.
>>
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> ---
>>   fs/fsopen.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/fsopen.c b/fs/fsopen.c
>> index ce03f6521c88..6593ae518115 100644
>> --- a/fs/fsopen.c
>> +++ b/fs/fsopen.c
>> @@ -465,6 +465,7 @@ SYSCALL_DEFINE5(fsconfig,
>>           param.file = fget(aux);
>>           if (!param.file)
>>               goto out_key;
>> +        param.dirfd = aux;
>>           break;
>>       default:
>>           break;
