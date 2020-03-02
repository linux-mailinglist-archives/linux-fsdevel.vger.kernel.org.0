Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF751764EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 21:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCBU3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 15:29:00 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:50027 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbgCBU27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:28:59 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id E02217CF;
        Mon,  2 Mar 2020 15:28:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 02 Mar 2020 15:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        Ww9qGc+lcoLsKB6qm47YN46Hs/OW9aokKUSjQbk+rdk=; b=g8jZPnFFFjLpeqe2
        XTQmJo99obPuLd8cMi9nJn1DHXfK/y3DwOquh2OdsfDOFAh5PdoQVCEadG6Rg6rs
        Le6J1/ZBq4iwNhEdzG9ijzkEaeQxr44r2C0A+Ax0l3Z7HiyLD+BUCOYgK88evBz5
        1sjdym2lq5gsky+H8/1egOXg7qmKFvAvcQYfHX0mI554/J/reidyVx4w5TKXBL0Y
        QTh8cEYoEk1TFsuYcZwRLETq3L5xqPZVLqdbSGjBjpLA9aL1Khe5TXwReA+SyiZL
        z94fJWX0Krwngj748MtgX6KBi5ANHvH7pQolK2SmUDL91fBsXojhNsLaD6C7zwYG
        PpdaFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Ww9qGc+lcoLsKB6qm47YN46Hs/OW9aokKUSjQbk+r
        dk=; b=yBYY4b/N9J8jpaREnNXPrgUJ5AeoFAzOhL47EgemlDuKdGkCswiWP166u
        utXWaLGwpo8jpBmrUvjmaBRvbZYsj7uJUxEp6ALZcPZu0ulILBEihKvzzjDkeeIP
        vAHbhefQZqivla03mDo8Ta3WkA7SAajAGcAt2pzLwrJSYRdzVZY3wbwsC2VlFgdf
        EsnDz7vBst9n8/+esMohoxOiOKXAkbx0buaoUkIyriItKeOqjLwOUn4lDTt+Av6r
        luCpI3wC24StEx7AzFs9AZ5jJaN4Ruu0Q6T9dT98LspS7n6HgHe2D8WQiTHel4mo
        Qwi+flKpnN7crU1WhfjFwMyn66nhA==
X-ME-Sender: <xms:imxdXg-MXR98bHVMyoBgNYHfhn3tod3pcVIZm4jmQAqEGGv04I-owA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtgedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecukfhppe
    dukeehrdefrdelgedrudelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:imxdXlAJKUhNz43puknZqjnO_oazXelQ1EvZ8yVNkJJ4qMuiIsS0tg>
    <xmx:imxdXozglZwemLOZdcTIQ8wAlkdXZPSgWDtGIEVEqlZIUr6YuVtPGA>
    <xmx:imxdXiQDMpUPvivKN1Sf8P2jtOxRdx7Ig-eA2bhpCmRS3Z5hmjlV-Q>
    <xmx:imxdXu0yNpl5CafFHLZ9ikagGBr-ZbnL9nuVnBFLn2Gx3cWM027VVQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0170F328005E;
        Mon,  2 Mar 2020 15:28:58 -0500 (EST)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 07572D6;
        Mon,  2 Mar 2020 20:28:57 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id D2966E00B8; Mon,  2 Mar 2020 20:28:56 +0000 (GMT)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [fuse] Effects of opening with O_DIRECT
References: <8736as2ovb.fsf@vostro.rath.org>
        <CAJfpegupesjdOe=+rrjPNmsCg_6n-67HrS4w2Pm=w4ZrQOdj1Q@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel
        <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <mszeredi@redhat.com>
Date:   Mon, 02 Mar 2020 20:28:56 +0000
In-Reply-To: <CAJfpegupesjdOe=+rrjPNmsCg_6n-67HrS4w2Pm=w4ZrQOdj1Q@mail.gmail.com>
        (Miklos Szeredi's message of "Mon, 2 Mar 2020 10:47:28 +0100")
Message-ID: <8736aqv6uv.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mar 02 2020, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Sun, Mar 1, 2020 at 2:20 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>>
>> Hi,
>>
>> What happens if a file (on a FUSE mountpoint) is opened without
>> O_DIRECT, has some data in the page cache, and is then opened a second
>> with O_DIRECT?
>>
>> Will reads with O_DIRECT come from the page cache (if there's a hit), or
>> be passed through to the fuse daemon?
>
> O_DIRECT read will try first directly, and fall back to the cache on
> short or zero return count.
>
>>
>> What happens to writes (with and without O_DIRECT, and assuming that
>> writeback caching is active)? It seems to me that in order to keep
>> consistent, either caching has to be disabled for both file descriptors
>> or enabled for both...
>
> This is not a fuse specific problem.   The kernel will try to keep
> things consistent by flushing dirty data before an O_DIRECT read.
> However this mode of operation is not recommended.  See open(2)
> manpage:
[...]

Is there currently any other way to execute a read request while making
sure that data does not end-up in the page cache (unless it happens to
be there already)?

I have full control of userspace, so I could do something like read from
a pseudo-extended attribute (assuming there's no size limitations), but
I'm not sure if this is better than O_DIRECT...


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
