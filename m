Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1811B075E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgDTLX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 07:23:59 -0400
Received: from albireo.enyo.de ([37.24.231.21]:39026 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDTLX6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:23:58 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jQUWn-00057d-MO; Mon, 20 Apr 2020 11:23:53 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jQUWn-0002tR-Jr; Mon, 20 Apr 2020 13:23:53 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
References: <20200331133536.3328-1-linus.walleij@linaro.org>
        <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
Date:   Mon, 20 Apr 2020 13:23:53 +0200
In-Reply-To: <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
        (Peter Maydell's message of "Mon, 20 Apr 2020 12:19:17 +0100")
Message-ID: <87v9luwgc6.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Peter Maydell:

> We open fd 3 to read '.'; we issue the new fcntl, which
> succeeds. Then there's some unrelated stuff operating on
> stdout. Then we do a getdents64(), but the d_off values
> we get back are still 64 bits. The guest binary doesn't
> like those, so it fails. My expectation was that we would
> get back d_off values here that were in the 32 bit range.

What's your file system?

I think not all of them have 32-bit hashes (some of them probably
can't, particularly in the network-based file system case).
