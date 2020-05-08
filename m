Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DBD1CB2CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHP3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 11:29:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52817 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbgEHP3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 11:29:46 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 12AA25C01D2;
        Fri,  8 May 2020 11:29:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 08 May 2020 11:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        o7+iZNTEOvr0ADpNDDv8Z0wUbWtj9Zi+aBJlpBe4pdg=; b=TtGE6bbrWAAmZbFb
        yz85soIHMwjPbZW21EkPOXsu3qFwdy3vxbx7v2veRHkm9zyGaG1f4LMis5/QDaKA
        /jhByptEvfBSlcNoeDDUOrJD7IcwdMxZ6hYfpw/rZmPmAUh00BffPH/hcZmIwws1
        +11TsRw/9jDtVFUs/HE3g9QW7aXqAYvQm+dvkcwW6jP5vyXV4NXq+vRFmeWwxGOo
        3jiO8jGH8M4Baos6/K1jvweJKRD+96lWFvlftqp1phFoDVr7VN1OPUF1mRUOuArV
        uNS5iBLwQA2oGGW4M8TtW62iTotTaG9I958HJA2oPolZp5BHWs/T5xkvNGjq0KfT
        vI7gzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=o7+iZNTEOvr0ADpNDDv8Z0wUbWtj9Zi+aBJlpBe4p
        dg=; b=s4ibGc85HYgUTdFS2l4IReriwJxY5zrkczIY7rO46mdzhhJBFjQo2Shl7
        87cwaXdSYPvRZz7aZLluMs5fgljkUxwWQVe4r0qzgcJIrJYfShMY8hUoYcRpAKfK
        /Wj3dUwJpIBiNQRt86nVrZtRTMXG/zfQusy1SgOoMwe/xNyYd1IVlrFzngcLrHoC
        wtg+SIO+IypVjIhfZmWg+eg2eWtZOYE/++eViBu8ckewRu5CcpEvSrzr9g2XsXzD
        Otbj4MngVX9VYayz9zbm4haYDunWeTIn+3t06dvTx9VOAB6ocRNeUsdUVw+0UVN1
        SikHk6bqmMRD4N+vxSboM05OEfeSA==
X-ME-Sender: <xms:6Hq1XmyUUi5qKAu_y0XNApCc0MpKPuH7JbPqXclP8Al0oH7HdeEhfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkeefgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhkohhl
    rghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrfgrth
    htvghrnhephfetueeghedutdefteegudfgjefhfedthfehgeegkeejueevieeljedtfeef
    ffehnecukfhppedukeehrdefrdelgedrudelgeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:6Hq1Xghqhj0dKK9LK0InW6U4lxmIoMzOCxDVRP4Zehw1AvlaLg6jjQ>
    <xmx:6Hq1XhdNp0PyJpgpqiHopeyruW-2iaDF4OZFsceCzPAJmAAIuK3AOg>
    <xmx:6Hq1XtumR666j-vqrhRfeq0zGck4i8ScwNqXOw9pYnzOyDLV49Qk-A>
    <xmx:6Xq1Xo__-MKVsTAviid0hrWKxNRBxwuqg68EgvWvJQ3mQ9vCvQTyNQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 83EEA3280059;
        Fri,  8 May 2020 11:29:44 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id B153C49;
        Fri,  8 May 2020 15:29:43 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id DDAFBE33CD; Fri,  8 May 2020 16:28:30 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [fuse-devel] [fuse] Getting visibility into reads from page cache
References: <87k123h4vr.fsf@vostro.rath.org>
        <CAJfpeguqV=++b-PF6o6Y-pLvPioHrM-4mWE2rUqoFbmB7685FA@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, fuse-devel
        <fuse-devel@lists.sourceforge.net>
Date:   Fri, 08 May 2020 16:28:30 +0100
In-Reply-To: <CAJfpeguqV=++b-PF6o6Y-pLvPioHrM-4mWE2rUqoFbmB7685FA@mail.gmail.com>
        (Miklos Szeredi's message of "Mon, 27 Apr 2020 11:26:16 +0200")
Message-ID: <874ksq4fa9.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Apr 27 2020, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Sat, Apr 25, 2020 at 7:07 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>>
>> Hello,
>>
>> For debugging purposes, I would like to get information about read
>> requests for FUSE filesystems that are answered from the page cache
>> (i.e., that never make it to the FUSE userspace daemon).
>>
>> What would be the easiest way to accomplish that?
>>
>> For now I'd be happy with seeing regular reads and knowing when an
>> application uses mmap (so that I know that I might be missing reads).
>>
>>
>> Not having done any real kernel-level work, I would start by looking
>> into using some tracing framework to hook into the relevant kernel
>> function. However, I thought I'd ask here first to make sure that I'm
>> not heading into the completely wrong direction.
>
> Bpftrace is a nice high level tracing tool.
>
> E.g.
>
>   sudo bpftrace -e 'kretprobe:fuse_file_read_iter { printf ("fuse
> read: %d\n", retval); }'

Thanks, this looks great! I had to do some reading about bpftrace first,
but I think this is exacly what I'm looking for. A few more questions:


- If I attach a probe to fuse_file_mmap, will this tell me whenever an
  application attempts to mmap() a FUSE file?

- I believe that (struct kiocb*)arg0)->ki_pos will give me the offset
  within the file, but where can I see how much data is being read?

- What is the best way to connect read requests to a specific FUSE
  filesystems (if more than one is mounted)? I found the superblock in
  (struct kiocb*)arg0)->ki_filp->f_mapping->host->i_sb->s_fs_info, but I
  do not see anything in this structure that I could map to a similar
  value that FUSE userspace has access to...

- I assume fuse_file_read_iter is called for every read request for FUSE
  filesystems unless it's an mmap'ed access. Is that right?

- Is there any similar way to catch access to an mmap'ed file? I think
  there is probably a way to make sure that every memory read triggers a
  page fault and then hook into the fault handler, but I am not sure how
  difficult this is to do and how much performance this would cost....

- If my BPF program contains e.g. a printf statement, will execution of
  the kernel function block until the printf has completed, or is there
  some queuing mechanism?

Thanks for your help!


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
