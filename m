Return-Path: <linux-fsdevel+bounces-236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464067C7BAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 04:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C5C1C21093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 02:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E34A56;
	Fri, 13 Oct 2023 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="h98MYJKT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jt+wF3cE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABD365
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 02:40:05 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C4DDE;
	Thu, 12 Oct 2023 19:40:03 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 646F45C0380;
	Thu, 12 Oct 2023 22:40:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 12 Oct 2023 22:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1697164801; x=1697251201; bh=v/NfjpcqgjT4cCUGFXPV+Rh0Ny4ORRueTJG
	R6kwHMb8=; b=h98MYJKTyJxh5BlvDbqEbS/QDtKUAxWwg2gGTDuH6bPyNZVeWqr
	wx7264K7BBz32R/co1ATerAhNOMz75YLvm0fgTpgMMNQu55w/LVhZfVZ8OAJaCJq
	7nb9dXr37pUg3xsw+b7il6/ccYQEcPhPb1vK4CCQEDrzy95IV5o4SoOHlrLXJpUS
	Eb6yPF/vCqUumwQwHr6SUOmSXmec1KGdbHy/VnWCwJ1VS7MFAVN4kRWjtDai5r4e
	6Iyb5UfYgyfG6nkNOqOd32AZHM4b4h2XiUHG2i77ha6HhTxsKzAs97rGYCPcA6Jm
	X5Z16cCuPlMvm2fDFuvmbQ+0wtUWZGtKmxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1697164801; x=1697251201; bh=v/NfjpcqgjT4cCUGFXPV+Rh0Ny4ORRueTJG
	R6kwHMb8=; b=Jt+wF3cEaxzWcr3/XY+Wti7uxW1slOr+Hh/k2JZeVBiHjcLII+Z
	nY0JUMQAUmDbFKRWkpDfuKIptHIvAR4kGoNSizhDviET/VuKiZVCLSJwzXlYZuVd
	CpnkeoHXGKe3B0+EamZEayG0kSpjwW7ne9v4AUmksO5OEuGQtcIFvB9B8Tp7Kdlb
	8KnNMyLprmaqX8wELioBDQZV7M5B73HYVbhOMQu/7XxjsD97mBwdVhOEsAQdEYiM
	4Zs6ZIclabu89A++eIi9tF47Z7p4t5528a4i5yVVr0vyQgwSV2oj8Dm/R1FxOYyU
	hjjXgGv4TTuQcjNkFh96NNn3NsYXWo/LI0g==
X-ME-Sender: <xms:AK4oZfYmg8hEeYfVAyN9-NVArxIb9pHAIGMu3LtUcRruvGFiFXYofA>
    <xme:AK4oZea2lrufPdbPIb_b2cpZxrufVNi-KdhmDGxE6gD8ljT5zvF1TCt_XZjTxXcnY
    ctZD-IlCEos>
X-ME-Received: <xmr:AK4oZR_c5k74EqiyFt1B-u0NuLBMh1OUK8IicBC-0xnMyiMUjlVPKb21xDJnQHX7pAYonr_C7pXIwMswwGu5E6yaqAnpZ1_E9drmkcuN1Xom8hNHEleP_4lU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedugdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfhvfevfhfujggtgfesthekredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ekueffkefhffetjeeikeevtdfhgefhgeetfedvgeevveejgeffleelffekveejtdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:AK4oZVr_hhUjuDK8v1CelxtwSzRQiPkQJ28QaIhT5GG36oeAhMe8dA>
    <xmx:AK4oZapZISNp-1EU-J-rAeME2Ys8rS-j8-lysqiKkCn9cG15lAW-6g>
    <xmx:AK4oZbSFYIFmjcllZIBS8h0RkMXumwjif1oWQKDJk2WMEEF9D0_4Rw>
    <xmx:Aa4oZVB9SQ5uAQPRwuokl4D2K98Gt4SH7aFjq0x66MdNJYh_gIZC1A>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 22:39:53 -0400 (EDT)
Message-ID: <c45fc3e5-05ca-14ab-0536-4f670973b927@themaw.net>
Date: Fri, 13 Oct 2023 10:39:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Ian Kent <raven@themaw.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Paul Moore <paul@paul-moore.com>, Miklos Szeredi <mszeredi@redhat.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org,
 linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
 David Howells <dhowells@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>,
 Amir Goldstein <amir73il@gmail.com>, Matthew House
 <mattlloydhouse@gmail.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>
References: <20230928130147.564503-1-mszeredi@redhat.com>
 <20230928130147.564503-5-mszeredi@redhat.com>
 <CAHC9VhQD9r+Qf5Vz1XmxUdJJJO7HNTKdo8Ux=n+xkxr=JGFMrw@mail.gmail.com>
 <CAJfpegsPbDgaz46x4Rr9ZgCpF9rohVHsvuWtQ5LNAdiYU_D4Ww@mail.gmail.com>
 <a25f2736-1837-f4ca-b401-85db24f46452@themaw.net>
 <CAJfpegv78njkWdaShTskKXoGOpKAndvYYJwq7CLibiu+xmLCvg@mail.gmail.com>
 <7fe3c01f-c225-394c-fac5-cabfc70f3606@themaw.net>
Content-Language: en-US
Subject: Re: [PATCH v3 4/4] add listmount(2) syscall
In-Reply-To: <7fe3c01f-c225-394c-fac5-cabfc70f3606@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/10/23 08:27, Ian Kent wrote:
> On 5/10/23 23:47, Miklos Szeredi wrote:
>> On Thu, 5 Oct 2023 at 06:23, Ian Kent <raven@themaw.net> wrote:
>>
>>> The proc interfaces essentially use <mount namespace>->list to provide
>>>
>>> the mounts that can be seen so it's filtered by mount namespace of the
>>>
>>> task that's doing the open().
>>>
>>>
>>> See fs/namespace.c:mnt_list_next() and just below the m_start(), 
>>> m_next(),
>> /proc/$PID/mountinfo will list the mount namespace of $PID. Whether
>> current task has permission to do so is decided at open time.
>>
>> listmount() will list the children of the given mount ID.  The mount
>> ID is looked up in the task's mount namespace, so this cannot be used
>> to list mounts of other namespaces.  It's a more limited interface.
>
> Yep. But isn't the ability to see these based on task privilege?
>
>
> Is the proc style restriction actually what we need here (or some 
> variation
>
> of that implementation)?
>
>
> An privileged task typically has the init namespace as its mount 
> namespace
>
> and mounts should propagate from there so it should be able to see all 
> mounts.
>
>
> If the file handle has been opened in a task that is using some other 
> mount
>
> namespace then presumably that's what the program author wants the 
> task to see.
>
> So I'm not sure I see a problem obeying the namespace of a given task.

I've had a look through the code we had in the old fsinfo() proposal

because I think we need to consider the use cases that are needed.


IIRC initially we had a flag FSINFO_ATTR_MOUNT_CHILDREN that essentially

enumerated the children of the given mount in much the same way as is

done now in this system call.


But because we needed to enumerate mounts in the same way as the proc file

system mount tables a flag FSINFO_ATTR_MOUNT_ALL was added that essentially

used the mount namespace mounts list in a similar way to the proc file

system so that a list of mounts for a mount namespace could be retrieved.


This later use case is what is used by processes that monitor mounts and

is what's needed more so than enumerating the children as we do now.


I'm still looking at the mount id lookup.


Ian

>
>
> Ian
>
>>
>> I sort of understand the reasoning behind calling into a security hook
>> on entry to statmount() and listmount().  And BTW I also think that if
>> statmount() and listmount() is limited in this way, then the same
>> limitation should be applied to the proc interfaces.  But that needs
>> to be done real carefully because it might cause regressions. OTOH if
>> it's only done on the new interfaces, then what is the point, since
>> the old interfaces will be available indefinitely?
>>
>> Also I cannot see the point in hiding some mount ID's from the list.
>> It seems to me that the list is just an array of numbers that in
>> itself doesn't carry any information.
>>
>> Thanks,
>> Miklos

