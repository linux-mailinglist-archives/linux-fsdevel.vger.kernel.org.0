Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1383D1CB558
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 19:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHRFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 13:05:50 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51445 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbgEHRFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 13:05:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C5F55C01F3;
        Fri,  8 May 2020 13:05:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 08 May 2020 13:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        jDHydD+6BCPSvhs8uR+ChWtBD5nHPXar/DRi9kzp9Rc=; b=JqXbJZecDueHIIzA
        mDcuJMevKU5F09ZTl3LD7AwzJ5l9J4lOQ5pYWkHZSvoSom08RAz3xRYRmDUeAUMS
        keAbcXIk32CJi6rO7+HtT22m7FTlhHW6HMHjIdiOQMJAzcGRDjxufytovWJ2cZZU
        MzFpUShXpSnocQ4aNS62z+oSCCUm6PCtGcuM68IX83SGXOt9tUBCT3BNjEAZv5RI
        HWiHbBVn7YePRDB+aZuDS7FV56LkgAM/f6s46kIyndg5JIJhzPyBl8rVscFCkSXh
        mtNKX11QB1NT1cS2Cmhc4aKdYiAh8Q8DH21497AyYQjVB36PiBgmmCo8uec4q9qz
        rmZIkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=jDHydD+6BCPSvhs8uR+ChWtBD5nHPXar/DRi9kzp9
        Rc=; b=MYfiYdVKFHdisWsV65Sdw73Oglc63scG0xTQs2ON49SyRZekoW0m5qj3d
        0FrsYv5yxHX03zfPUS3sosE0GqfF4MGC4N+cE5ga+pfElIG0WAWL7hbBwB2QQu9B
        xigVJUEOVWST5D9WHh4tJF87ekqoI0sv7boUU+KYpdUj1UWGVL+aeoS0FivWoCAE
        lI3XrlInznx0SG5pvd0EX7lyv0A3XPHDyCIAWF9yb6xCp9o0TSRM0FVgmAZbRuM8
        KzeXq0d5tYCJPsGvq75Ca84D/njSZ4poFMaLngfmXC9UVIm3v/UunauONsLXVxEk
        VlJVJxY6G9N2OL7/IOznE9qI9ImCw==
X-ME-Sender: <xms:bJG1XoDMDnUsdJoEZ75He1sVKXXQ4mS6QXTKIMtrtCqIvcGoB7UWJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkeefgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhkohhl
    rghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuggftrfgrth
    htvghrnhephfetueeghedutdefteegudfgjefhfedthfehgeegkeejueevieeljedtfeef
    ffehnecukfhppedukeehrdefrdelgedrudelgeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:bJG1XpAlDEO9QzxJKcrbNk9y9Qv4WmbK1ZRbd6bBWAZkZfhhRD8Zcg>
    <xmx:bJG1XiTUZECJDHYPK03p92MbOywS6gfXR2JVr-blnaIaY4opqc-e4A>
    <xmx:bJG1Xt6V61aZeR14_8M3WzJPSb1KRoFOuok4vfhcSADyVkX57MSP1g>
    <xmx:bZG1XjY2J5z9V4k9woB-mnkYhlrpS-JRaxXOOThxLI9TlQ4AkWkrXQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4D913328005D;
        Fri,  8 May 2020 13:05:48 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 1DEE549;
        Fri,  8 May 2020 17:05:47 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 3AE30E33CD; Fri,  8 May 2020 18:04:34 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [fuse-devel] [fuse] Getting visibility into reads from page cache
References: <87k123h4vr.fsf@vostro.rath.org>
        <CAJfpeguqV=++b-PF6o6Y-pLvPioHrM-4mWE2rUqoFbmB7685FA@mail.gmail.com>
        <874ksq4fa9.fsf@vostro.rath.org>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, fuse-devel
        <fuse-devel@lists.sourceforge.net>
Date:   Fri, 08 May 2020 18:04:34 +0100
In-Reply-To: <874ksq4fa9.fsf@vostro.rath.org> (Nikolaus Rath's message of
        "Fri, 08 May 2020 16:28:30 +0100")
Message-ID: <871rnu4au5.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 08 2020, Nikolaus Rath <Nikolaus@rath.org> wrote:
>>
>>   sudo bpftrace -e 'kretprobe:fuse_file_read_iter { printf ("fuse
>> read: %d\n", retval); }'
>
>
> - I believe that (struct kiocb*)arg0)->ki_pos will give me the offset
>   within the file, but where can I see how much data is being read?

Looking at the code in fuse_file_read_iter, it seems the length is in
((struct iov_iter*)arg1)->count, but I do not really understand why.

The definiton of this parameter is:

struct iov_iter {
	int type;
	const struct iovec *iov;
	unsigned long nr_segs;
	size_t iov_offset;
	size_t count;
};

..so I would think that *count* is the number of `iovec` elements hiding
behind the `iov` pointer, not some total number of bytes.

Furthermore, there is a function iov_length() that is documented to
return the "total number of bytes covered by an iovec" and doesn't look
at `count` at all.

Can someone elucidate why the number of bytes to be read from the file
is in iov_iter.count?


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
