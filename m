Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3BDBF2C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 14:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfIZMSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 08:18:21 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33037 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbfIZMSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:18:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5D3012F12;
        Thu, 26 Sep 2019 08:18:20 -0400 (EDT)
Received: from imap37 ([10.202.2.87])
  by compute3.internal (MEProxy); Thu, 26 Sep 2019 08:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TF2e2v
        5QJWANq2RvA+l4zDSrT7f1zxrbP1wF6DFeYtk=; b=COZ7Z/I6Ef2JAcktyDpH1t
        fr6D5NZkAOJUOLF0SGltqlpNJX9DU06wPkTMsVjm1d6bEWTCS9mG5zCqEQxCe7I9
        BBLG13s6cvcu3jCb13mdtr+BjtxsubwtiC7UJhIIaCgwHhBW7s5bH1vr3mcXIswT
        6BzHiKqaWo8cJip2TD46PETshG3/wCRgoPr0VR6rQwop8UddmV8d2AkL+IaxSd/Z
        qsA3kz4tM3ev0ilBWmzDyytZjhj5/slzUSDbFfgqM9R8PZfraY3R14edkYN/hvQJ
        XvVa2UExj6XdVyXxmrnhz4yeCGzCKo+22/z/j/a8BZmjB3uFxvDvMgAp53Vb1Xsg
        ==
X-ME-Sender: <xms:i6yMXSKaUZVQZ7rWMip8-_zkAm-iCIFY0LqoKU_m0rFjl1V61HQtnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrfeeggdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfveholhhi
    nhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucfrrg
    hrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:i6yMXbagZiMTzWbLhoZzfgOzY8whui0r9xdyVl-mcfPJeVU66BQiyQ>
    <xmx:i6yMXfxO8N17h4AOgUB9dnnNE5y1la8eneUmL_ilk5AfvrEiY9JvBQ>
    <xmx:i6yMXaYLvJGpAeq6bAVXDICDDPMPoKY2ERyALyDJ-wa1tjryBXhpVg>
    <xmx:jKyMXWWhcAHq6sUJsEsGjfthlIK4MdOW_S_MoHC_J1grcEJCbRm2Og>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6954C684005E; Thu, 26 Sep 2019 08:18:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-305-g4111847-fmstable-20190924v1
Mime-Version: 1.0
Message-Id: <4e6e03c1-b2f4-4841-99af-cbb75f33c14d@www.fastmail.com>
In-Reply-To: <FF3F534F-B40D-4D7D-956B-F1B63C4751CC@fb.com>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader> <20190924193513.GA45540@vader>
 <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
 <20190925071129.GB804@dread.disaster.area>
 <60c48ac5-b215-44e1-a628-6145d84a4ce3@www.fastmail.com>
 <FF3F534F-B40D-4D7D-956B-F1B63C4751CC@fb.com>
Date:   Thu, 26 Sep 2019 08:17:12 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Chris Mason" <clm@fb.com>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Jann Horn" <jannh@google.com>,
        "Omar Sandoval" <osandov@osandov.com>,
        "Aleksa Sarai" <cyphar@cyphar.com>, "Jens Axboe" <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Kernel Team" <Kernel-team@fb.com>,
        "Andy Lutomirski" <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] add RWF_ENCODED for writing compressed data
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, Sep 25, 2019, at 10:56 AM, Chris Mason wrote:

> The data is verified while being decompressed, but that's a fairly large 
> fuzzing surface (all of zstd, zlib, and lzo).  A lot of people will 
> correctly argue that we already have that fuzzing surface today, but I'd 
> rather not make a really easy way to stuff arbitrary bytes through the 
> kernel decompression code until all the projects involved sign off.

Right.  So maybe have this start of as a BTRFS ioctl and require
privileges?   I assume that's sufficient for what Omar wants.

(Are there actually any other popular Linux filesystems that do transparent compression anyways?)
