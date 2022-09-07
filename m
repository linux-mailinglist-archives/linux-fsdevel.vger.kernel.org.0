Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CF75B01C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 12:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiIGKWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 06:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiIGKVk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:21:40 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A35F71
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 03:19:21 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E9B833200928;
        Wed,  7 Sep 2022 06:18:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Sep 2022 06:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662545908; x=
        1662632308; bh=t6GHXso1Xz/VmtCcYz3YrGtCx+h2GyXocmtXkVVyuQM=; b=V
        XIrwSc9QExh34xSWRSIRZBDG2jRj28Rheg6T6he5klJDv3PgIHOv/MAIN3AKdlpB
        t4TrmwgJsVXtA6Sfh2O/kbaAOJxVwKpuQ5rc0y3B1sNHuJYPot8dbFKIP+g9QQXo
        fe3QWqI0WiqBhn0KdweAKYKckRYMtoaoTIFBrgl9tdMir9DltFuiyShU0IbUCdyi
        E4qZ9nAAP+nhK3GywSH9Ek5KilcI9+wQM561VX0+f+/Is271PoZPaLxz71TRDe5H
        BHTCHznzL8RR9RRe67GiRBZQlKyXB4Tj1DOXT3LDQMRnbh8foPWlywTyN3M12UMw
        35wnN89hAyJngSK62RgvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662545908; x=
        1662632308; bh=t6GHXso1Xz/VmtCcYz3YrGtCx+h2GyXocmtXkVVyuQM=; b=U
        sG+30IcB4HKwKcs6wTJw47qX0Cc/N+mpLMB+9rI/LUBI498s9/H1aDmt2DM3Nck0
        Vs1cC8gAyHFQLrbov/vMFKmuusQvY+xai/FAHbYWD/7vfR2zYNktLLe+TueR9L4D
        MhYH13xGjKTL099ET8DrRnf8XyA0XyOQzNRDhxKoDj8pVYcOtQrsMKQjltkwTQuR
        Qyrk9UWzRTHjKjJtmOGu37iZBDraJe401k5Zv5VA7ZbyBizowePYxl4kQNQVL4Nh
        VfWWwd97a/AOt3DlKi+LQM2AcL+EjUcPRxvvCTn2tQx2rTN8Z/bFoT+Sc3g2Dq0H
        62IPr/6aKGw8Y7hAhnmfA==
X-ME-Sender: <xms:9G8YYzLdCTSfK9A0bWN5daQYqBEXBl3YeXj3bgbkEZLFajNCuPD2tg>
    <xme:9G8YY3I2_JI5puWQCOS_2VuDB1wd6wu671u9tZNgdpPCAD1dMC2uibdobB4kD6bcp
    XM2blJlOjDoMvqo>
X-ME-Received: <xmr:9G8YY7vyxTIBAnbShoPzgzqzYxUMVmM7EOrtzDptEhln4j6RTqanjxND-IGKQRviwZWgCcuixCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepgedvkefftdfhkefhieetkeeikeegieejfeelfeefhfejgeelheeghfeh
    udeuleefnecuffhomhgrihhnpehnrghrkhhivhgvrdgtohhmpdhfohhsuggvmhdrohhrgh
    dpuggvsghirghnrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomheppfhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:9G8YY8bHo6mZ_JeKTOy0bHQGJm353hbpQlrLVATW0yKg_I8zXClItQ>
    <xmx:9G8YY6a3A3txuiwwsHHpDcQdrix1U3o0P8TXDkYnr4iYQ8Aib2ZNjQ>
    <xmx:9G8YYwDygnncbkjMkGuNqDftQjffVTkA7OyYJtnUQixVvzvLd1W2dQ>
    <xmx:9G8YYxyOkYd9d8yrgYp0vllnUA1-zOL8vIv8x90b8mqERHwtWpC0xQ>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 06:18:27 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 502E7AFF;
        Wed,  7 Sep 2022 10:18:26 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 64888DBE34; Wed,  7 Sep 2022 11:18:25 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Wouter Verhelst <w@uter.be>
Cc:     nbd@other.debian.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Subject: Re: Why do NBD requests prevent hibernation, and FUSE requests do not?
References: <87k06qb5to.fsf@vostro.rath.org>
        <YxH79CbXDUEa+r/2@pc220518.home.grep.be>
Mail-Copies-To: never
Mail-Followup-To: Wouter Verhelst <w@uter.be>, nbd@other.debian.org, Linux FS
        Devel <linux-fsdevel@vger.kernel.org>, miklos <mszeredi@redhat.com>
Date:   Wed, 07 Sep 2022 11:18:25 +0100
In-Reply-To: <YxH79CbXDUEa+r/2@pc220518.home.grep.be> (Wouter Verhelst's
        message of "Fri, 2 Sep 2022 14:49:56 +0200")
Message-ID: <8735d3sd1q.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Wouter,

FUSE communication happens through a pipe on the same host, so this
could in principle be used to make sure that the FUSE daemon isn't
frozen too early. But (per Bernd's response) it seems that this
information isn't actually used (since
https://linux-kernel.vger.kernel.narkive.com/UeBWfN1V/patch-fuse-make-fuse-=
daemon-frozen-along-with-kernel-threads)
hasn't been applied. So I guess I've just been exceptionally
lucky/unlucky in my FUSE/NBD experiments.

That said, since NBD can also operate over unix domain sockets I was
hoping that perhaps in that scenario there would be some way to
establish the same link for NBD?


Best,
-Nikolaus

On Sep 02 2022, Wouter Verhelst <w@uter.be> wrote:
> Hi Nikolaus,
>
> I do not know how FUSE works, so can't comment on that.
>
> NBD, however, is a message-passing protocol: the client sends a message
> to request something over a network socket, which causes the server to
> do some processing, and then to send a message back. As far as the
> kernel is concerned (at least outside nbd.ko), there is no connection
> between the request message and the reply message.
>
> As such, when the kernel suspends the nbd server, it has no way of
> knowing that the in-kernel client is still waiting on a reply for a
> message that was sent earlier.
>
> I'm guessing that for FUSE, there is such a link?
>
> On Tue, Aug 30, 2022 at 07:31:31AM +0100, Nikolaus Rath wrote:
>> Hello,
>>=20
>> I am comparing the behavior of FUSE and NBD when attempting to hibernate
>> the system.
>>=20
>> FUSE seems to be mostly compatible, I am able to suspend the system even
>> when there is ongoing I/O on the fuse filesystem.
>>=20
>> With NBD, on the other hand, most I/O seems to prevent hibernation the
>> system. Example hibernation error:
>>=20
>>   kernel: Freezing user space processes ...=20
>>   kernel: Freezing of tasks failed after 20.003 seconds (1 tasks refusin=
g to freeze, wq_busy=3D0):
>>   kernel: task:rsync           state:D stack:    0 pid:348105 ppid:34810=
4 flags:0x00004004
>>   kernel: Call Trace:
>>   kernel:  <TASK>
>>   kernel:  __schedule+0x308/0x9e0
>>   kernel:  schedule+0x4e/0xb0
>>   kernel:  schedule_timeout+0x88/0x150
>>   kernel:  ? __bpf_trace_tick_stop+0x10/0x10
>>   kernel:  io_schedule_timeout+0x4c/0x80
>>   kernel:  __cv_timedwait_common+0x129/0x160 [spl]
>>   kernel:  ? dequeue_task_stop+0x70/0x70
>>   kernel:  __cv_timedwait_io+0x15/0x20 [spl]
>>   kernel:  zio_wait+0x129/0x2b0 [zfs]
>>   kernel:  dmu_buf_hold+0x5b/0x90 [zfs]
>>   kernel:  zap_lockdir+0x4e/0xb0 [zfs]
>>   kernel:  zap_cursor_retrieve+0x1ae/0x320 [zfs]
>>   kernel:  ? dbuf_prefetch+0xf/0x20 [zfs]
>>   kernel:  ? dmu_prefetch+0xc8/0x200 [zfs]
>>   kernel:  zfs_readdir+0x12a/0x440 [zfs]
>>   kernel:  ? preempt_count_add+0x68/0xa0
>>   kernel:  ? preempt_count_add+0x68/0xa0
>>   kernel:  ? aa_file_perm+0x120/0x4c0
>>   kernel:  ? rrw_exit+0x65/0x150 [zfs]
>>   kernel:  ? _copy_to_user+0x21/0x30
>>   kernel:  ? cp_new_stat+0x150/0x180
>>   kernel:  zpl_iterate+0x4c/0x70 [zfs]
>>   kernel:  iterate_dir+0x171/0x1c0
>>   kernel:  __x64_sys_getdents64+0x78/0x110
>>   kernel:  ? __ia32_sys_getdents64+0x110/0x110
>>   kernel:  do_syscall_64+0x38/0xc0
>>   kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>   kernel: RIP: 0033:0x7f03c897a9c7
>>   kernel: RSP: 002b:00007ffd41e3c518 EFLAGS: 00000293 ORIG_RAX: 00000000=
000000d9
>>   kernel: RAX: ffffffffffffffda RBX: 0000561eff64dd40 RCX: 00007f03c897a=
9c7
>>   kernel: RDX: 0000000000008000 RSI: 0000561eff64dd70 RDI: 0000000000000=
000
>>   kernel: RBP: 0000561eff64dd70 R08: 0000000000000030 R09: 00007f03c8a72=
be0
>>   kernel: R10: 0000000000020000 R11: 0000000000000293 R12: fffffffffffff=
f80
>>   kernel: R13: 0000561eff64dd44 R14: 0000000000000000 R15: 0000000000000=
001
>>   kernel:  </TASK>
>>=20
>> (this is with ZFS on top of the NBD device).
>>=20
>>=20
>> As far as I can tell, the problem is that while an NBD request is
>> pending, the atsk that waits for the result (in this case *rsync*) is
>> refusing to freeze. This happens even when setting a 5 minute timeout
>> for freezing (which is more than enough time for the NBD request to
>> complete), so I suspect that the NBD server task (in this case nbdkit)
>> has already been frozen and is thus unable to make progress.
>>=20
>> However, I do not understand why the same is not happening for FUSE
>> (with FUSE requests being stuck because the FUSE daemon is already
>> frozen). Was I just very lucky in my tests? Or are tasks waiting for
>> FUSE request in a different kind of state? Or is NBD a red-herring here,
>> and the real trouble is with ZFS?
>>=20
>> It would be great if someone  could shed some light on what's going on.
>>=20
>>=20
>> Best,
>> -Nikolaus
>>=20
>> --=20
>> GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>>=20
>>              =C2=BBTime flies like an arrow, fruit flies like a Banana.=
=C2=AB
>>=20
>>=20
>
> --=20
>      w@uter.{be,co.za}
> wouter@{grep.be,fosdem.org,debian.org}
>
> I will have a Tin-Actinium-Potassium mixture, thanks.


--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
