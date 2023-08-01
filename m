Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0E676B95A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjHAQF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 12:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjHAQF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:05:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1D61996
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 09:05:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DB97E5C00D4;
        Tue,  1 Aug 2023 12:05:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 01 Aug 2023 12:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1690905953; x=1690992353; bh=nO
        5DGjeIsutrs2uJ626SDXn1fcBjOv8s3a1cSCtAGic=; b=Fjv2EvfkRR7JD/t7YU
        S+a8JgBnKJ7tnBtAm9Bkm1ZNx8F7We0k+7n8Qxi5oTlVbS6THxePmjfkE8D+69sR
        E/mYUAZdY82whewnUx7A9QdGNY6CzPo0Qi1XIfsHnhDPYMUDUYCHdJNpeookoB57
        Ot7a7s4e3NZhzCFTXAh3RVNuh6d4aj/kYLUR33ggalJvi9YkTLcoTdKWvgBJsDP2
        H3pS87w2npB01JI80bU0Gu/vR/pi2vXNYDi+Vl9BEGB+3VRhi9ESQ3YPB2su6bcC
        KO9mI31ZyaFvU0Rdg5TMIgmVF21yimwBn0poUCICs2dWsnSLxLqmFEjmLVFFdEng
        uyXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690905953; x=1690992353; bh=nO5DGjeIsutrs
        2uJ626SDXn1fcBjOv8s3a1cSCtAGic=; b=uvXADTDcS79SrOD/8jhN1gdM5//mj
        bfruIshaoSDEpEndihfd73NcIigud6+r6ftMLoZ3NOj0CZxbru+JcyIxajja5Ahe
        eU5tSrz7qagAQR9aYEZugySGoXG5UkNhijnUFLPFEt6gm+RNLe8M1dp3pBawanBY
        2o+/9B0M/0T1wCKcEWGmlF9LuIPIozesHpkH3uGLDceWoHVjfsMWRwufxIn97cOD
        4pqxqjxTRd9ogz+cmbu9n8K4EI4M7mAUGxktf+AtY48fC42RhcQi1FkpMIrBFTPq
        GaD+B/dyBo/jl7VfF8yLeWhpDVG3/U5zLMbIn6OBn7fS2Q11oEL63oMww==
X-ME-Sender: <xms:YS3JZI49jQ5VVi41WswcPZrHwuRbCnA2wLjSPcnW-5F8I3hKVvn7GA>
    <xme:YS3JZJ7lTkI4tPFWWR8DbffqHfn-y3nlVZOxx7TBHJy_6myPZGuzF5lIbcH9K1wMB
    -OXARX1F2gxxBfw>
X-ME-Received: <xmr:YS3JZHcQ7Map0iuYl2glODpROdewikEcNwNbbEQWEtWIv9-8xN8jTUqdCwCZzozgaffvVxVDlqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufhfffgjkfgfgggtsehttddttddtredtnecuhfhrohhmpefpihhkohhl
    rghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrfgrth
    htvghrnhepteekleehieffleeuvdelkeekvdettedtteehhfeiheektdeljeelffeuvdej
    udevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:YS3JZNJY5W1lKSv80GfbTqWl1mo2p_z6JdOONOVVJgy8JWFHLUyMjw>
    <xmx:YS3JZMJBTxIr46sYJoN-DCA1hldbwNBefO4ET2unNHzt5-_0eJI_Lg>
    <xmx:YS3JZOznkVzuiazPgve4A-o_I25T6zFw9xApX11JCZ0xr7LmwdnVhg>
    <xmx:YS3JZGgRmLh78LooanvXhk4r-TSUdyirkEvbLTDsczEEWLCcro4Ntg>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 12:05:52 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 666E2C0F;
        Tue,  1 Aug 2023 16:05:51 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id E701687274; Tue,  1 Aug 2023 17:05:50 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Martin Kaspar via fuse-devel <fuse-devel@lists.sourceforge.net>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
References: <87wmymk0k9.fsf@vostro.rath.org>
        <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
        <87tttpk2kp.fsf@vostro.rath.org> <87r0osjufc.fsf@vostro.rath.org>
        <CAJfpegu7BtYzPE-NK_t3nFBT3fy2wGyyuJRP=wVGnvZh2oQPBA@mail.gmail.com>
        <CAJfpeguJESTqU7d0d0_2t=99P3Yt5a8-T4ADTF3tUdg5ou2qow@mail.gmail.com>
        <87o7jrjant.fsf@vostro.rath.org>
        <CAJfpegvTTUvrcpzVsJwH63n+zNw+h6krtiCPATCzZ+ePZMVt2Q@mail.gmail.com>
        <2e44acdd-b113-43c3-80cb-150f09478383@app.fastmail.com>
        <CAJfpegtoi2jNaKjvqMqrWQQrDoJkTZqheXFAb3MMVv7WVsHi0A@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>, Martin Kaspar via
        fuse-devel <fuse-devel@lists.sourceforge.net>, Linux FS Devel
        <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue, 01 Aug 2023 17:05:50 +0100
In-Reply-To: <CAJfpegtoi2jNaKjvqMqrWQQrDoJkTZqheXFAb3MMVv7WVsHi0A@mail.gmail.com>
        (Miklos Szeredi's message of "Tue, 1 Aug 2023 16:48:03 +0200")
Message-ID: <87mszarbmp.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Aug 01 2023, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Tue, 1 Aug 2023 at 16:40, Nikolaus Rath <nikolaus@rath.org> wrote:
>>
>> On Tue, 1 Aug 2023, at 13:53, Miklos Szeredi via fuse-devel wrote:
>> > Here's one with the virtual env and the correct head:
>> >
>> > root@kvm:~/s3ql# git log -1 --pretty="%h %s"
>> > 3d35f18543d9 Reproducer for notify_delete issue. To confirm:
>> > root@kvm:~/s3ql# ~/s3ql-python-env/bin/python bin/s3qlrm mnt/test
>> > WARNING: Received unknown command via control inode
>> > ERROR: Uncaught top-level exception:
>> > Traceback (most recent call last):
>> >   File "/root/s3ql/bin/s3qlrm", line 21, in <module>
>> >     s3ql.remove.main(sys.argv[1:])
>> >   File "/root/s3ql/src/s3ql/remove.py", line 72, in main
>> >     pyfuse3.setxattr(ctrlfile, 'rmtree', cmd)
>> >   File "src/pyfuse3.pyx", line 629, in pyfuse3.setxattr
>> > OSError: [Errno 22] Invalid argument: 'mnt/test/.__s3ql__ctrl__'
>>
>> This is odd. I have never heard of anyone having this problem before and it also works fine in the CI.
>>
>> I apologize that this is taking so much of your time.
>>
>> I have changed the code a bit to print out what exactly it is receiving:
>> https://github.com/s3ql/s3ql/commit/eb31f7bff4bd985d68fa20c793c2f2edf5db61a5
>>
>> Would you mind updating your branch and trying again? (You'll need to fetch and reset,
>> since I rebased on top of current master just to be sure).
>>
>> I can still reproduce this every time (without any other error):
>>
>> $ mkdir bucket
>> $ bin/mkfs.s3ql --plain local://bucket
>> Before using S3QL, make sure to read the user's guide, especially
>> the 'Important Rules to Avoid Losing Data' section.
>> Creating metadata tables...
>> Uploading metadata...
>> Uploading metadata...
>> Uploaded 1 out of ~1 dirty blocks (100%)
>> Calculating metadata checksum...
>> $ mkdir mnt
>> $ bin/mount.s3ql --fg local://bucket mnt &
>> Using 10 upload threads.
>> Autodetected 1048514 file descriptors available for cache entries
>> Using cached metadata.
>> Setting cache size to 315297 MB
>> Mounting local:///home/nikratio/in-progress/s3ql/bucket/ at /home/nikratio/in-progress/s3ql/mnt...
>>
>> $ md mnt/test; echo foo > mnt/test/bar
>> $ bin/s3qlrm mnt/test
>> fuse: writing device: Directory not empty
>> ERROR: Failed to submit invalidate_entry request for parent inode 1, name b'test'
>> Traceback (most recent call last):
>>   File "src/internal.pxi", line 125, in pyfuse3._notify_loop
>>   File "src/pyfuse3.pyx", line 915, in pyfuse3.invalidate_entry
>> OSError: [Errno 39] fuse_lowlevel_notify_delete returned: Directory not empty
>>
>> nikratio@vostro ~/i/s3ql (notify_delete_bug)>
>
> WARNING: Received unknown command via control inode: b"1, b'test')"
> ERROR: Uncaught top-level exception:
> Traceback (most recent call last):
>   File "/root/s3ql/bin/s3qlrm", line 21, in <module>
>     s3ql.remove.main(sys.argv[1:])
>   File "/root/s3ql/src/s3ql/remove.py", line 74, in main
>     pyfuse3.setxattr(ctrlfile, 'rmtree', cmd)
>   File "src/pyfuse3.pyx", line 629, in pyfuse3.setxattr
> OSError: [Errno 22] Invalid argument: 'mnt/test/.__s3ql__ctrl__'

Thanks! It looks like the extended attribute name and value that S3QL
receives from libfuse is corrupted. What reaches S3QL as the xattr name
is actually the truncated xattr value (leading parenthesis is missing).

Is it possible that you are running into a variant of
https://github.com/libfuse/libfuse/issues/730? This was fixed in libfuse
3.14.1 and introduced in 3.13.0.

Best,
-Nikolaus

