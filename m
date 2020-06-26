Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41C520ABD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 07:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgFZF1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 01:27:07 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46785 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725306AbgFZF1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 01:27:05 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id B4AFD5C0126;
        Fri, 26 Jun 2020 01:27:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 26 Jun 2020 01:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        vK+yMABEL91rfcYj+lUlRmeQixM5qaFhnXkR8mk2OFs=; b=U4FWCWRBRP4l2KCq
        l9a4CSe6Cww9qvDu1Iow6ce4UcD82132IyQxs8JgM1dq3Gdqv988hTXzmSwv9AY/
        rtC7hnNTxM84tQSUJdBHgNd2GkZfm3bTm+i6JpsKosUcR3dRJX1Buz48qWgBNEbx
        oxwwNX1J2arNCPWuyxdLscQKMLvyeD11+MQmyaKYl9DItM5MxNJ6tg1YcORXJNZ2
        jqEQ8VROeOthCIQrJc9/Diqb/umwvG2t0Mg45w0OvyhsnCfC7lCG+CWhSMqUT6tM
        8GOCEwgsXs6BKt6r5+WxyY56gFBGvXxK9nB6vtB/ayZ87wuoPSlkePKNJ0fPRqkG
        g576vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=vK+yMABEL91rfcYj+lUlRmeQixM5qaFhnXkR8mk2O
        Fs=; b=dRk8Pw09ntIUsIcZM/8MN7mSxznwu2vGph9uVzRn5UeHge80nIzLq7Gox
        vAlCxIAC6ErCQKfESGDstdK5u128ZUk4Z8l2BOkyPYCVmLI0RBCpsMsIwSYLUuYM
        pEtYhTho0HbvGfrglOUrPP9YdUU6m6lb4VwFWXOktZEG1+uHShbQnVhc511382sX
        Ws9UHzHuJRKgijBD1CozpkSQMqh2zx90IryBYhATG8xjJi6RzXRz2j62BIHFk4sG
        6uAqTpDS7bPo8B4ynzL19eoU9gdGNoQPOBaifACnMtH28/aUIGcWvsx7iTdAHP2+
        M1zSxDmp9HUnpSL+v7uIb/KvXhXYA==
X-ME-Sender: <xms:KIf1XhzWDzYw62uVdQhQPqAhOs4lWZrXLKkCjfTVmtdJXxofGBO-GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeltddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufhfffgjkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhho
    lhgruhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrg
    htthgvrhhnpeegfeejvdeujeeukefghfdtfeetiefhtedvgfevgfehffehgfektdfgkedv
    gfevfeenucffohhmrghinhepohhpvghnghhrohhuphdrohhrghenucfkphepudekhedrfe
    drleegrdduleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheppfhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:KIf1XhRu4TAucrs8HrXa5S8-o4QGRWeAingnUC6LKW0AqyuBJ_PZcw>
    <xmx:KIf1XrUusiL_tSoLSv0vqnnLIPEQ7HCYmONF6FliRT2PTqfzILH7jQ>
    <xmx:KIf1XjjtkyU-7_bdp66x5y4hT2Hxi39PrmDN_5cYwGkCYah3BNQXVQ>
    <xmx:KIf1Xu5Y5X9RpJcgk3-6etOPVf_w37hBKkxBaDbzBzWJPiNOo1tsQg>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id E43A83280059;
        Fri, 26 Jun 2020 01:27:03 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 01B7B41;
        Fri, 26 Jun 2020 05:27:02 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id C09CBE0339; Fri, 26 Jun 2020 06:27:02 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [fuse-devel] 512 byte aligned write + O_DIRECT for xfstests
References: <CAMHtQmP_TVR8QA+noWQk04Nj_8AxMXfjCj1K_k0Zf6BN-Bq9sg@mail.gmail.com>
        <87bllhh7mg.fsf@vostro.rath.org>
        <CAMHtQmPcADq0WSAY=uFFyRgAeuCCAo=8dOHg37304at1SRjGBg@mail.gmail.com>
        <877dw0g0wn.fsf@vostro.rath.org>
        <CAJfpegs3xthDEuhx_vHUtjJ7BAbVfoDu9voNPPAqJo4G3BBYZQ@mail.gmail.com>
        <87sgensmsk.fsf@vostro.rath.org>
        <CAOQ4uxiYG3Z9rnXB6F+fnRtoV1e3k=WP5-mgphgkKsWw+jUK=Q@mail.gmail.com>
        <87mu4vsgd4.fsf@vostro.rath.org>
        <CAOQ4uxgqrT=cxyjAE+FAJzfnJ1=YS91t8aidXSqxPTsEoR90Vw@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Amir Goldstein <amir73il@gmail.com>, fuse-devel
        <fuse-devel@lists.sourceforge.net>, linux-fsdevel
        <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, Dave Chinner
        <dchinner@redhat.com>
Date:   Fri, 26 Jun 2020 06:27:02 +0100
In-Reply-To: <CAOQ4uxgqrT=cxyjAE+FAJzfnJ1=YS91t8aidXSqxPTsEoR90Vw@mail.gmail.com>
        (Amir Goldstein's message of "Mon, 22 Jun 2020 10:57:50 +0300")
Message-ID: <874kqycs7t.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jun 22 2020, Amir Goldstein <amir73il@gmail.com> wrote:
>> >> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap0=
2.html#tag_15_09_07
>> >>
>> >> Thanks for digging this up, I did not know about this.
>> >>
>> >> That leaves FUSE in a rather uncomfortable place though, doesn't it?
>> >> What does the kernel do when userspace issues a write request that's
>> >> bigger than FUSE userspace pipe? It sounds like either the request mu=
st
>> >> be splitted (so it becomes non-atomic), or you'd have to return a sho=
rt
>> >> write (which IIRC is not supposed to happen for local filesystems).
>> >>
>> >
>> > What makes you say that short writes are not supposed to happen?
>>
>> I don't think it was an authoritative source, but I I've repeatedly read
>> that "you do not have to worry about short reads/writes when accessing
>> the local disk". I expect this to be a common expectation to be baked
>> into programs, no matter if valid or not.
>
> Even if that statement would have been considered true, since when can
> we speak of FUSE as a "local filesystem".
> IMO it follows all the characteristics of a "network filesystem".
>
>> > Seems like the options for FUSE are:
>> > - Take shared i_rwsem lock on read like XFS and regress performance of
>> >   mixed rw workload
>> > - Do the above only for non-direct and writeback_cache to minimize the
>> >   damage potential
>> > - Return short read/write for direct IO if request is bigger that FUSE
>> > buffer size
>> > - Add a FUSE mode that implements direct IO internally as something li=
ke
>> >   RWF_UNCACHED [2] - this is a relaxed version of "no caching" in clie=
nt or
>> >   a stricter version of "cache write-through"  in the sense that
>> > during an ongoing
>> >   large write operation, read of those fresh written bytes only is ser=
ved
>> >   from the client cache copy and not from the server.
>>
>> I didn't understand all of that, but it seems to me that there is a
>> fundamental problem with splitting up a single write into multiple FUSE
>> requests, because the second request may fail after the first one
>> succeeds.
>>
>
> I think you are confused by the use of the word "atomic" in the standard.
> It does not mean what the O_ATOMIC proposal means, that is - write everyt=
hing
> or write nothing at all.
> It means if thread A successfully wrote data X over data Y, then thread B=
 can
> either read X or Y, but not half X half Y.
> If A got an error on write, the content that B will read is probably unde=
fined
> (excuse me for not reading what "the law" has to say about this).
> If A got a short (half) write, then surely B can read either half X or ha=
lf Y
> from the first half range. Second half range I am not sure what to expect.
>
> So I do not see any fundamental problem with FUSE write requests.
> On the contrary - FUSE write requests are just like any network protocol =
write
> request or local disk IO request for that matter.
>
> Unless I am missing something...

Well, you're missing the point I was trying to make, which was that FUSE
is in an unfortunate spot if we want to avoid short writes *and* comply
with the standard. You are asserting that is perfectly fine for FUSE to
return short writes and I agree that in that case there is no problem
with making writes atomic.

I do not dispute that FUSE is within its right to return short
rights. What I am saying is that I'm sure that there are plenty of
userspace applications that don't expect short writes or reads when
reading *any* regular file, because people assume this is only a concern
for fds that represents sockets or pipes. Yes, this is wrong of
them. But it works almost all the time, so it would be unfortunate if it
suddenly stopped working for FUSE in the situations where it previously
worked.


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
