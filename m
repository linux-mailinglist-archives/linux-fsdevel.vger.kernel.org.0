Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8004BDDC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405385AbfIYMHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 08:07:47 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45313 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388199AbfIYMHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:07:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1EAC6224DC;
        Wed, 25 Sep 2019 08:07:45 -0400 (EDT)
Received: from imap37 ([10.202.2.87])
  by compute3.internal (MEProxy); Wed, 25 Sep 2019 08:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=on/VQ5
        eHbmJCO8XUQdTV6gYockvWAtQkQ7buFdi82FM=; b=S/A9tkO1+QkKiB5znDHlq8
        H6/wVx6EMzl6lBe7ObWrK6yTjHBb6LN73+6646CZyI4sgnMsH59AWYALMGMYC9ix
        GVHpqWtsMubRypHQUMCWnWlu3Pdezyd8LQZ9zl33wJF77kFmS6ZJTNRY4RchnHVU
        OGGX4YCuUcsv/zI5NyqjEL7j9wvikwWh+Jn1CxMquJ3OL8HqgzKatkdrCJTgQ0Eh
        hA8+Bvj6pZXH6MpQ9Js8Ropbu8z30Qp2VqhfiQWBKA5tglagGiFPd9NXUlMQMcKJ
        OZ0U2amNLxysIPTXwBLjO3W/CBve7betm5xPWToxzii2H2Y8HBQGa/E/0HkEhdxw
        ==
X-ME-Sender: <xms:j1iLXSwLcZtO1Ub7uyg0b8JTSf05e3KZXEOW3-nWuimip6w9E1W2UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrfedvgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfveholhhi
    nhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucfrrg
    hrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:j1iLXdNO5sdbDAC6kbfd5R3DJgB5zKfNgeLkp562IIrIowsynjKmVA>
    <xmx:j1iLXQaVD-Dj7A_4FySHrX2y_1xFjK1U6ld69wAww6RUCh6Sn5bzkA>
    <xmx:j1iLXcBH8Vyu0Pir3ym0hDoERNsFhYCra5X2Yi7N5ZJdMmtVsMoA2g>
    <xmx:kViLXSV--n8ttvJraT682_1-H3h05BIi6zDhmpHoLzbhjyXqyS4Umw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 89255684005E; Wed, 25 Sep 2019 08:07:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-305-g4111847-fmstable-20190924v1
Mime-Version: 1.0
Message-Id: <60c48ac5-b215-44e1-a628-6145d84a4ce3@www.fastmail.com>
In-Reply-To: <20190925071129.GB804@dread.disaster.area>
References: <cover.1568875700.git.osandov@fb.com>
 <230a76e65372a8fb3ec62ce167d9322e5e342810.1568875700.git.osandov@fb.com>
 <CAG48ez2GKv15Uj6Wzv0sG5v2bXyrSaCtRTw5Ok_ovja_CiO_fQ@mail.gmail.com>
 <20190924171513.GA39872@vader> <20190924193513.GA45540@vader>
 <CAG48ez1NQBNR1XeVQYGoopEk=g_KedUr+7jxLQTaO+V8JCeweQ@mail.gmail.com>
 <20190925071129.GB804@dread.disaster.area>
Date:   Wed, 25 Sep 2019 08:07:12 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     "Dave Chinner" <david@fromorbit.com>,
        "Jann Horn" <jannh@google.com>
Cc:     "Omar Sandoval" <osandov@osandov.com>,
        "Aleksa Sarai" <cyphar@cyphar.com>, "Jens Axboe" <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        "Kernel Team" <kernel-team@fb.com>,
        "Andy Lutomirski" <luto@kernel.org>
Subject: Re: [RFC PATCH 2/3] fs: add RWF_ENCODED for writing compressed data
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, Sep 25, 2019, at 3:11 AM, Dave Chinner wrote:
>
> We're talking about user data read/write access here, not some
> special security capability. Access to the data has already been
> permission checked, so why should the format that the data is
> supplied to the kernel in suddenly require new privilege checks?

What happens with BTRFS today if userspace provides invalid compressed data via this interface?  Does that show up as filesystem corruption later?  If the data is verified at write time, wouldn't that be losing most of the speed advantages of providing pre-compressed data?

Ability for a user to cause fsck errors later would be a new thing that would argue for a privilege check I think.
