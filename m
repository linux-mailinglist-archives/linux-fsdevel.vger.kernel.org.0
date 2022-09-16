Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B4C5BA7C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 10:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiIPIH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiIPIGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:06:39 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477E5D125
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 01:05:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 58B0E3200B15;
        Fri, 16 Sep 2022 04:05:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 16 Sep 2022 04:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1663315524; x=
        1663401924; bh=DpGEM9lfiq2Xus0TNrTxUqZ9DBjKf+k0dABgR0oK4Bo=; b=D
        XUYvDTfjOmT68tVPfiuHwoInrv1XTyY4xOX85VtdlgnFZ7xWpThzp/uM6/n65MNh
        DB3y8gv8W+aj7plg4kEvdXyxfIiOTqgAV8IV8LtAuC3IXh7wG1fMBPNaj/qToQ4I
        IVHjIxSqan/ROGr1dHoPbPFrtKJvkvnkNz2gRzv8WnTepfb9HFKfXUh/PWFBNtEl
        6R8ckItQcVrRhNVZjHegETiPRE9pORkN8RmZAW9IbqKDrKddY61qhQFHE2a1H7AD
        ApP76fUoOs4l4SBhn0X7J1oIw+wvrGvmB0J4T8k1LJjYuKLT100H9PgL26ofeYnW
        p8XHOb2aCgbsh91NI/+rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663315524; x=
        1663401924; bh=DpGEM9lfiq2Xus0TNrTxUqZ9DBjKf+k0dABgR0oK4Bo=; b=v
        PQy9rwvKYM9fSw8AQdUP+wPFhKGIHKZb/BhBMkiHQ3cFa7p+NAnTlti+HZDVEEbn
        BxoE/Ykex8Bsru5Ha0INxSWY2CnHEBP9I0LszJOz+58/xiK72vGBEqXywLLSgcRf
        xueLum9FdzjotJatvkiszNsKY4lwoAnRcPhgANe72dxin6cNRaNqJb8yDr+F59lw
        UyCNxZxEnAf4jArnH7881Oj5CdERyvU3otw2cDhlhBYlHcA17ztMCoeT4RFNzE4R
        4xQmeecY0MQHvZbAmDQXh1ieyrRkgZbz17PyCTmT0657Xdcfy3rdg0ho7jtu5SPf
        Y4mw8I/XSm9NnPU+Qn9DQ==
X-ME-Sender: <xms:RC4kY8eJhfBiWTmvur1isQj1d30l9I-g9kRMcvKk4llTMlI2Djf8Iw>
    <xme:RC4kY-OPDkCc9gCuVSldx0dP7vOtW0qSSkT-JQsRjfcFYKKbdcYAiMAu_PlM833jt
    C5x4TUsZ82J2cLx>
X-ME-Received: <xmr:RC4kY9iNHdKedBpbhXfAQhtnDEsB6uu5MjKw6780UsN1tLridnPh_KiIIjY29JrSe5eKlmXkelI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvtddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrf
    grthhtvghrnhepvedtgeegtdduveffgeegueegleekkeeghfdttefhleevhfekfeduvdfh
    udegueegnecuffhomhgrihhnpehfohhsuggvmhdrohhrghdpuggvsghirghnrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheppfhikhho
    lhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:RC4kYx_hCFyZljq2kJ4dZB_h9bxpbA-cCRv5tlCEMapc6RuBCB6HWw>
    <xmx:RC4kY4t44dB3soSP6l0egk6xV7IxOOJdTV9LvsXMeEbgGag-Qcxvaw>
    <xmx:RC4kY4HRV62uSNosbmEYoTH_k3qKDDE0Iw8-r9DAvX8623n_eWQcqw>
    <xmx:RC4kYyW4-9QVrZGRnlBC-o7vknUmQmw9q7vc60QqnJxYt1WeYUtOrQ>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Sep 2022 04:05:24 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id D4E85BD0;
        Fri, 16 Sep 2022 08:05:22 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 45F47D82AF; Fri, 16 Sep 2022 09:05:22 +0100 (BST)
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
Date:   Fri, 16 Sep 2022 09:05:22 +0100
In-Reply-To: <YxH79CbXDUEa+r/2@pc220518.home.grep.be> (Wouter Verhelst's
        message of "Fri, 2 Sep 2022 14:49:56 +0200")
Message-ID: <87mtazrbgd.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Wouter,

Following up on this: should the NBD server perhaps set
PR_SET_IO_FLUSHER, and the kernel freeze tasks with this flag last?

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
