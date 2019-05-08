Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0666A17353
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfEHILA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 04:11:00 -0400
Received: from mail133-31.atl131.mandrillapp.com ([198.2.133.31]:47199 "EHLO
        mail133-31.atl131.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbfEHILA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 04:11:00 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2019 04:10:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=k6xxt/3kcIYL7oHUmKqKRsF4bdAZAtMRpKsnmgM5468=;
 b=IW+d8qjEwQLiRgF1R0fpdH+E0syL0FeSIXjYIdGcoqsXvBqswEsnEONUtBbhrc4mz2GrLcQEM+55
   89sVT7w9PSq3rS+fPc9nsZLkv8H5MVr+h6UYBbaxBeFAjK3jfR6DrK+jQst7yanxBNpG/bTrL5zz
   fqXgxqyy8GyD+VHDR2o=
Received: from pmta02.mandrill.prod.atl01.rsglab.com (127.0.0.1) by mail133-31.atl131.mandrillapp.com id hqa7h61sar8l for <linux-fsdevel@vger.kernel.org>; Wed, 8 May 2019 07:40:58 +0000 (envelope-from <bounce-md_31050260.5cd2880a.v1-39ce5dc8f92b48e7990c71bfa80ff650@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1557301258; h=From : 
 Subject : To : Cc : Message-Id : References : In-Reply-To : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=k6xxt/3kcIYL7oHUmKqKRsF4bdAZAtMRpKsnmgM5468=; 
 b=QjPuaOYmbFNdd3rQYgdgpjdY/b5tnKtpVWuncfR7KaxxD9/3MyIa/+68WW8FGWDsbn6T5T
 2tUc+nxAKjVsef8d5jWvrK6tRZIapMWA9U/AEyRrjWk76eyRheLwPIJoxmZUB1TqFofcD/A5
 6Gn2oW9jUw1l9HY2UHlS1+ppKoPuA=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH 0/3] stream_open bits for Linux 5.2
Received: from [87.98.221.171] by mandrillapp.com id 39ce5dc8f92b48e7990c71bfa80ff650; Wed, 08 May 2019 07:40:58 +0000
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@denx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Message-Id: <20190508074048.GA2907@deco.navytux.spb.ru>
References: <cover.1557162679.git.kirr@nexedi.com> <CAHk-=wg1tFzcaX2v9Z91vPJiBR486ddW5MtgDL02-fOen2F0Aw@mail.gmail.com> <20190507190939.GA12729@deco.navytux.spb.ru> <CAHk-=wgWusqMfU25eBofgBHVSrQaVxr-EwCPCWcBaFMjzf_=Cg@mail.gmail.com>
In-Reply-To: <CAHk-=wgWusqMfU25eBofgBHVSrQaVxr-EwCPCWcBaFMjzf_=Cg@mail.gmail.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.39ce5dc8f92b48e7990c71bfa80ff650
X-Mandrill-User: md_31050260
Date:   Wed, 08 May 2019 07:40:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 07, 2019 at 12:18:03PM -0700, Linus Torvalds wrote:
> On Tue, May 7, 2019 at 12:09 PM Kirill Smelkov <kirr@nexedi.com> wrote:
> >
> > I've pushed corresponding gpg-signed tag (stream_open-5.2) to my tree. I
> > did not go the gpg way initially because we do not have a gpg-trust
> > relation established and so I thought that signing was useless.
> 
> Ok, since I hadn't pushed out my pull yet, I just re-did it with your
> signature, so that the key is visible in the git tree.

Thanks.
