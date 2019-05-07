Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E4F16B43
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2019 21:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfEGTYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 15:24:50 -0400
Received: from mail133-31.atl131.mandrillapp.com ([198.2.133.31]:29240 "EHLO
        mail133-31.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbfEGTYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 15:24:50 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 May 2019 15:24:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=5gGcRQhyinH7U9DuFvKdx+T0bB+kigGxniPOVUv+KfA=;
 b=WWDrHXtEy2HRayhBjakGL+/LKZPAJBtN+qBYE4viuyoccgSunVM5oT7Am9PS88hEAQWDRFWm7a6D
   +gAcMEAaUe1Em4wbXEsuYn4i+taCN/WWFYHzPBVXikDfm1MHoOAt4yHW7N9S//3b+wQaKAaPZZEt
   iAkBylscNx1INE3501o=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-31.atl131.mandrillapp.com id hq7do21sar8v for <linux-fsdevel@vger.kernel.org>; Tue, 7 May 2019 19:09:48 +0000 (envelope-from <bounce-md_31050260.5cd1d7fc.v1-7fb9fe7017fb4fe986d2648581a98ce6@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1557256188; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=5gGcRQhyinH7U9DuFvKdx+T0bB+kigGxniPOVUv+KfA=; 
 b=CCOJb8EmE2eAQWGnT3Esp9ITcvPgRWITuHfAviycDJrnQTH+JrDsXkiA4PF8S3C205lKVa
 rOVI3mqloGox4io5Sk/T2EeS70HCVEXrjfWJ13tCtzBZPzMkwxDDHFfiB3ZUVopCXDwO/vLv
 3fyNrV/yHteB1xTOYtlYxjfZcuSQ0=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 0/3] stream_open bits for Linux 5.2
Received: from [87.98.221.171] by mandrillapp.com id 7fb9fe7017fb4fe986d2648581a98ce6; Tue, 07 May 2019 19:09:48 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Message-Id: <20190507190939.GA12729@deco.navytux.spb.ru>
References: <cover.1557162679.git.kirr@nexedi.com> <CAHk-=wg1tFzcaX2v9Z91vPJiBR486ddW5MtgDL02-fOen2F0Aw@mail.gmail.com>
In-Reply-To: <CAHk-=wg1tFzcaX2v9Z91vPJiBR486ddW5MtgDL02-fOen2F0Aw@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.7fb9fe7017fb4fe986d2648581a98ce6
X-Mandrill-User: md_31050260
Date:   Tue, 07 May 2019 19:09:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 07, 2019 at 11:54:21AM -0700, Linus Torvalds wrote:
> On Mon, May 6, 2019 at 10:20 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > Maybe it will help: the patches can be also pulled from here:
> >
> >         git pull https://lab.nexedi.com/kirr/linux.git y/stream_open-5.2
> 
> I'll take this, but I generally *really* want a signed tag for
> non-kernel.org git tree sources. The gpg key used for signing doesn't
> necessarily even have to be signed by others yet, but just the fact
> that there's a pgp key means that then future pulls at least verify
> that it's the sam,e controlling entity, and we can get the signatures
> later.
>
> For something one-time where I will then look through the details of
> each commit it's not like I absolutely require it, which is why I'm
> pulling it, but just in general I wanted to point this out.
> 
>                         Linus

Thanks a lot.

I've pushed corresponding gpg-signed tag (stream_open-5.2) to my tree. I
did not go the gpg way initially because we do not have a gpg-trust
relation established and so I thought that signing was useless.

Just for the record, here is the key that was used to make the
signature: https://pgp.key-server.io/search/kirr@nexedi.com
(fingerprint: 0955B024250EEFFCFE42365B66CA788413F67549)

Kirill
