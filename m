Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2556025564C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgH1IVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgH1IVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:21:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7DEC06121B
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2020 01:21:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z15so130777plo.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2020 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=WyOqXSLQ4JpfeA85vm35K7wUyEbqfkXTTz8+VetWmBU=;
        b=T8XIEkGnN7foXnEvkHyH566CbiVLqHEQwx9+PFHl0rfHUOm7ND9LPoUoZFLE9E3zOx
         xcQ7Ce3dwfKfNVFx0MRHV+XzfktepsiUcTQAz8VjDwau5nSqmOi5QQh9TlBfW+K59OMk
         oP7p36dXl0qIae7ZrZKNiYK5/cxNryLsvS3mqlqOB4RYa0NeDK859bUv5vWjZR2h6x5F
         Ak5XTl+chy0p7Itf0TaakrEGS9X0vUqoN+EizYgS4VbnE3Wf4+Jj9dqGrYjIs5k/U/iI
         cUJ91dxQjWFuuVwYbfiwM4pZBXy0KIsO+XCn/9QRHH1snCwu/HKJ8bcu9fXnYLLWZcfh
         EbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=WyOqXSLQ4JpfeA85vm35K7wUyEbqfkXTTz8+VetWmBU=;
        b=hmZOvzddI4RI7W/0EW64hlCoSa3udpOocu/2JnXReZPuWoBCt2WXxIFbfZ2N5kOSUR
         lOOcJZXUjelR6tftuIoaVsuM91mI1COHlGzKWlUZgDiueeAnMreZbb+sZbziIZhU9+BA
         SJ7eMWU8A82hUv6pwd6+g3g5VADbQE2FpfbM7pJ0D1R+GpajTRzJvcPBTH7Qnyq2Bbnx
         DTvtE92Owj2yBBWX6JC8xczyV72YtJ3N8jIsE70CRd+Hi/iOKh2xLvI1q09O+eB8bvGe
         LCXH2IUJbE4XA0f7NFmIOQXwh4EgN/Ap99frqXUel9tDXwvlf6aywYFt4G94jwb/Q40+
         BI5w==
X-Gm-Message-State: AOAM530GNBpVhi260KUa3cDqKq+3W3Nxu4DCKFVy8+Q26P1klvy+YhXZ
        eDoudN33FtF1Qq29h+aFplb5Nw==
X-Google-Smtp-Source: ABdhPJzrgs6vnthgGLVcxP2WGEhq2pdT5OKq1A9Ar6r4d1F/ZOXQyouaoT+bslTYA0I6BEarTXFsrQ==
X-Received: by 2002:a17:90b:1214:: with SMTP id gl20mr257480pjb.225.1598602893008;
        Fri, 28 Aug 2020 01:21:33 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i1sm652055pfo.212.2020.08.28.01.21.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Aug 2020 01:21:32 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F9505A56-F07B-4308-BE42-F75ED76B4E3C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_55928913-301B-43F5-B831-95B05AD386EB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC 2/2] block: Do not discard buffers under a mounted
 filesystem
Date:   Fri, 28 Aug 2020 02:21:29 -0600
In-Reply-To: <20200825121616.GA10294@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        yebin <yebin10@huawei.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
References: <20200825120554.13070-1-jack@suse.cz>
 <20200825120554.13070-3-jack@suse.cz> <20200825121616.GA10294@infradead.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_55928913-301B-43F5-B831-95B05AD386EB
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Aug 25, 2020, at 6:16 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Tue, Aug 25, 2020 at 02:05:54PM +0200, Jan Kara wrote:
>> Discarding blocks and buffers under a mounted filesystem is hardly
>> anything admin wants to do. Usually it will confuse the filesystem and
>> sometimes the loss of buffer_head state (including b_private field) can
>> even cause crashes like:
> 
> Doesn't work if the file system uses multiple devices.

It's not _worse_ than the current situation of allowing the complete
destruction of the mounted filesystem.  It doesn't fix the problem
for XFS with realtime devices, or ext4 with a separate journal device,
but it fixes the problem for a majority of users with a single device
filesystem.

While BLKFLSBUF causing a crash is annoying, BLKDISCARD/BLKSECDISCARD
under a mounted filesystem is definitely dangerous and wrong.

What about checking for O_EXCL on the device, indicating that it is
currently in use by some higher level?

Cheers, Andreas






--Apple-Mail=_55928913-301B-43F5-B831-95B05AD386EB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9IvokACgkQcqXauRfM
H+DHZA/+PUI1hCcs8teTPcRlBxiD2xWoX/K1duYC51JuE3qo2RlI6LuN6sNGxBiA
Z/vyd0s31fwNGjDWdxsVTSO/vAc7NY8DcSeqNwPbv7AB+fI7Uwp9Ek1T/4MsWq11
5htpdhFKhCevZCaFUvPiYSBTf8wS6IUPSaVRHZs+3VdMYPhXQyt6x+84/4kcpojf
FBGzYi22oPazWge2/t0ee7zoS2nivK5V0C1ky96BoMOYTXN8kjI48oJEG2ypS3Co
ILxUZsYOoZqQYLSGpe+wjyjVqAqmZvXjogZaZ33WwogoODT4dQESYwMWE72J0Vwk
+gL3mXVQaoyEB4u4ps2g/I3gPPYsG+cLMv4agepLLeEYDq4KNcMH4WqWXFOd7A2r
qK2mXvnhvGvwOGV3brnyQ0q5MUmhUJ3jsZ1TXUt99OrstjLxN1Fvu/jaQA2RDXau
7IzulcHEABgo53Fq5FMCkPrYclzGdowH7sozRmNrc7OqB63SAAc+HZZZdFjH4A7/
PYjiyhq5MbnMstsuyxHGwU7Q7D/vUUpLaKZqRwkXF27pk1TTuv4ju0CkpjpxtHPy
e6ptx/EWc4kg2mRapYDyKjYrbmSduGr72Y7JN7Xv6Rd7V7BlKVSX262jWfrCE9ex
BoF6Feta85zMfWrMTqE3CioYPng96QVfXW0V8473UTcQwihEV/E=
=t+/I
-----END PGP SIGNATURE-----

--Apple-Mail=_55928913-301B-43F5-B831-95B05AD386EB--
