Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E05A605221
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiJSVnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 17:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJSVnI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:43:08 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50FD189811;
        Wed, 19 Oct 2022 14:43:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C5E325C01BD;
        Wed, 19 Oct 2022 17:43:03 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute2.internal (MEProxy); Wed, 19 Oct 2022 17:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666215783; x=1666302183; bh=aQhzaNxgmP
        CyXkjqZukBXqR9C223jX01tp+/o3aRhkA=; b=BfPDdlcS9/mNcIKtN34nyQS6Sq
        sUtCbJxWRckqV+agxcQMFjkJ6+Bmry+MSV96NMT4jyzk8wA5rw11PP/OQFtHV+hY
        htybgCd3ycGUN2CTDmmO1gwSoQsiQmI3LIncYWSD5F9htDzL0mmRqAKEm4wiwqUi
        I+h1sjiVM4EPx/KcmNWObAs+9FIlP1C1cbVxzFf52QDnwFCL462kGl/Hjt1Pmub9
        /NtcZt+RjRGyySnFT3yluvoBsX2PDx9CT5wgcWGhxJKKKYEdu3771mWHEheLtc8O
        D2VBY+yK+qT3KSFGcC8R840zGpTZ2yuimNWnZgFhwXX58u6qFsR70PNW5QRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666215783; x=1666302183; bh=aQhzaNxgmPCyXkjqZukBXqR9C223
        jX01tp+/o3aRhkA=; b=rAFvv0nkZG7jG3ShrELqOF0m6svhEGCwSiPVQ0flBynd
        xUXZMuFfpTE7x2oEwbcg8YOtlDXlzI5+iziNYUGovLQAAXgF0/1zDoqnuUO8U10p
        JUBaMS9uYvk1rD54K0mqH28luaDz2erxf4CU8KBKmMM6sJrgtYEVoQy8ch0NqR9v
        Zu1GPMwwz2iO6NNOObv569mFGGGHEUc5Vo+cJVo1zYrk3pDmJt2Okq3PZWsc4HjF
        rwUZPitUQkR0Q7+pgoN3WCRlKLi9Q6NqD/vKvutemJ6aVCkpN+pkpdSyfIcW1+pR
        /ONz6mvnkFywRqw60Y3tKz/YlKO5I0dSGOdQMlqyrQ==
X-ME-Sender: <xms:Z29QY3PcYe6jd-m18QguZDsBnTodAw6oaKJQbwDPgLLDQ9kepn7ZfA>
    <xme:Z29QYx9LtKdPCgNuC25lb0wUS2JEotEWlPGx6u90-KffanIwkQ2Jg59nGLRTm56sU
    DlT7s8CIKFWSjSrkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelhedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpedtudehudfhveduieeikeejudeljeffuddtieffieel
    jedtudehhfekheehuedvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Z29QY2QuNn3FDJtJlIVlBXNBCHdiqXzAsPzNGP2kRxNUUfgnLAeezQ>
    <xmx:Z29QY7sE074oTYVpJacOXEO-w4FrNQxn4LWWDlyHtBmEPDaA6P9c1Q>
    <xmx:Z29QY_fJwJjZvImL_pRJ47mwQd1H9dz1GJhwNhu7D4wLwnkCJyZBrw>
    <xmx:Z29QY3HMgZhD1AIIEZ5QkR-EJdrqBO-Ja3oD2mbQvyA8YkW2AmECUw>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6CD65BC0078; Wed, 19 Oct 2022 17:43:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <6ddd00bd-87d9-484e-8f2a-06f15a75a4df@app.fastmail.com>
In-Reply-To: <20221019132201.kd35firo6ks6ph4j@wittgenstein>
References: <f1e63e54-d88d-4b69-86f1-c0b4a0fd8035@app.fastmail.com>
 <20221019132201.kd35firo6ks6ph4j@wittgenstein>
Date:   Wed, 19 Oct 2022 15:42:42 -0600
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Christian Brauner" <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Odd interaction with file capabilities and procfs files
Content-Type: text/plain
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

On Wed, Oct 19, 2022, at 7:22 AM, Christian Brauner wrote:
> On Tue, Oct 18, 2022 at 06:42:04PM -0600, Daniel Xu wrote:
>> Hi,
>> 
>> (Going off get_maintainers.pl for fs/namei.c here)
>> 
>> I'm seeing some weird interactions with file capabilities and S_IRUSR
>> procfs files. Best I can tell it doesn't occur with real files on my btrfs
>> home partition.
>> 
>> Test program:
>> 
>>         #include <fcntl.h>
>>         #include <stdio.h>
>>         
>>         int main()
>>         {
>>                 int fd = open("/proc/self/auxv", O_RDONLY);
>>                 if (fd < 0) {
>>                         perror("open");
>>                         return 1;
>>                 }
>>        
>>                 printf("ok\n");
>>                 return 0;
>>         }
>> 
>> Steps to reproduce:
>> 
>>         $ gcc main.c
>>         $ ./a.out
>>         ok
>>         $ sudo setcap "cap_net_admin,cap_sys_admin+p" a.out
>>         $ ./a.out
>>         open: Permission denied
>> 
>> It's not obvious why this happens, even after spending a few hours
>> going through the standard documentation and kernel code. It's
>> intuitively odd b/c you'd think adding capabilities to the permitted
>> set wouldn't affect functionality.
>> 
>> Best I could tell the -EACCES error occurs in the fallthrough codepath
>> inside generic_permission().
>> 
>> Sorry if this is something dumb or obvious.
>
> Hey Daniel,
>
> No, this is neither dumb nor obvious. :)
>
> Basically, if you set fscaps then /proc/self/auxv will be owned by
> root:root. You can verify this:
>
> #include <fcntl.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <stdio.h>
> #include <errno.h>
> #include <unistd.h>
>
> int main()
> {
>         struct stat st;
>         printf("%d | %d\n", getuid(), geteuid());
>
>         if (stat("/proc/self/auxv", &st)) {
>                 fprintf(stderr, "stat: %d - %m\n", errno);
>                 return 1;
>         }
>         printf("stat: %d | %d\n", st.st_uid, st.st_gid);
>
>         int fd = open("/proc/self/auxv", O_RDONLY);
>         if (fd < 0) {
>                 fprintf(stderr, "open: %d - %m\n", errno);
>                 return 1;
>         }
>
>         printf("ok\n");
>         return 0;
> }
>
> $ ./a.out
> 1000 | 1000
> stat: 1000 | 1000
> ok
> $ sudo setcap "cap_net_admin,cap_sys_admin+p" a.out
> $ ./a.out
> 1000 | 1000
> stat: 0 | 0
> open: 13 - Permission denied
>
> So acl_permission_check() fails and returns -EACCESS which will cause
> generic_permission() to rely on capable_wrt_inode_uidgid() which checks
> for CAP_DAC_READ_SEARCH which you don't have as an unprivileged user.

Thanks for checking on this.

That does explain explain the weirdness but at the expense of another
question: why do fscaps cause /proc/self/auxv to be owned by root?
Is that the correct semantics? This also seems rather unexpected.

I'll take a look tonight and see if I can come up with any answers.

Thanks,
Daniel
