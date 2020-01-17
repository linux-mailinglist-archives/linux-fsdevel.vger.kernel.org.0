Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD08D140116
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 01:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgAQAqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 19:46:49 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49139 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbgAQAqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 19:46:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2C01D7539;
        Thu, 16 Jan 2020 19:46:48 -0500 (EST)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Thu, 16 Jan 2020 19:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Bj7tew
        rLhTxxbIYjCh4rz27oO210/CiYYk7GplSzEy8=; b=qMwotpyqVTtZxaUuZvgUko
        wa5sLBLFtrXwpDa6S8AFaeWgpPYxfYAWW4fNRTZYXnCOy4TM3qYvYXG7Oy2lNJ9w
        k1GOrmd3u/FGA/hXXYRVFu/4gPZkGzSqJVl1eU9/otOiPQDIjaDEzTH1qG3z+YdY
        aGteF1iysrJ4MP/y2OCAXMriq+kvEpaOykzzBguva1mpl9Z+p86NyvhiZ3QdnEU0
        c8+CB8HAMkdSKMYrGZtehj8+WIjyjtI3koNoMhjNTTC+oJpMOaUkTOPCZIoh9TtT
        xRfvG71B/j54TBy1OWgPfWH3eccrE31EZ+HGxxWTZL4yPVudnHlRLx4IZTJSpp2A
        ==
X-ME-Sender: <xms:9wMhXkU7VZX7XD8FoBgC0Xmb4M-AGRdq5c5NozFMLuiaOPGfVR2Ecw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtdeigddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfveholhhi
    nhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucffoh
    hmrghinhepkhgvrhhnvghlrdhorhhgnecurfgrrhgrmhepmhgrihhlfhhrohhmpeifrghl
    thgvrhhssehvvghrsghumhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:9wMhXiqac_TG3DDoK0mUIthfFYVjFCbyUDTuPI4F_X3uxp_RZGtqgQ>
    <xmx:9wMhXoS7TPA7XqiiOWlwjEC5EP6glsQt41-voAKHAipjpMF9yLd2Ww>
    <xmx:9wMhXk1qPSX_LJ1olcICAhuImDgUJgs679uyS3tTsCqgvy3ios9aeQ>
    <xmx:-AMhXi4NkJbWfDI6wfFdyhZMX_-weCeRVZYG87X59qU_RNY_xG7RKg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DD1EE660061; Thu, 16 Jan 2020 19:46:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-754-g09d1619-fmstable-20200113v1
Mime-Version: 1.0
Message-Id: <2397bb4a-2ca2-4b44-8c79-64efba9aa04d@www.fastmail.com>
In-Reply-To: <9351.1579025170@warthog.procyon.org.uk>
References: <20200114170250.GA8904@ZenIV.linux.org.uk>
 <3326.1579019665@warthog.procyon.org.uk>
 <9351.1579025170@warthog.procyon.org.uk>
Date:   Thu, 16 Jan 2020 19:46:25 -0500
From:   "Colin Walters" <walters@verbum.org>
To:     "David Howells" <dhowells@redhat.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, "Christoph Hellwig" <hch@lst.de>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Chris Mason" <clm@fb.com>, josef@toxicpanda.com, dsterba@suse.com,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Making linkat() able to overwrite the target
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020, at 1:06 PM, David Howells wrote:

> Yes, I suggested AT_LINK_REPLACE as said magical flag.

This came up before right?

https://lore.kernel.org/linux-fsdevel/cover.1524549513.git.osandov@fb.com/
