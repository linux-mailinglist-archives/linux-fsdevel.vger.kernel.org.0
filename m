Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE7214C12
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 13:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGELg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 07:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELg4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 07:36:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A92B120723;
        Sun,  5 Jul 2020 11:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593949016;
        bh=94G3FO32Kyz6wpkKsaBq7CitAiXlUf0xrn8UFv2qFwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BuURtRM1WoGQXApJms+b95y0FqDTuZ3MxD2CGCJQH8UG40SRvowIbe+vw1u+jtLq9
         fs/IGt+2cSopQJiVBCfR5iRvUQGNfUuZYw3GwC5HSMsxFbW7p7Tn8KIfUVVrQ4olZW
         G356Ub9u8H7WFqQJMBmbF2W2Bn/40Fg+V/QZCi3U=
Date:   Sun, 5 Jul 2020 13:36:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-man@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 3/3] selftests: add readfile(2) selftests
Message-ID: <20200705113658.GA1224775@kroah.com>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
 <20200704140250.423345-4-gregkh@linuxfoundation.org>
 <CAMuHMdXck1u+Djv1xOvRA7riMN4m3qp8o4zmXVvqrC1S+0fifA@mail.gmail.com>
 <20200705065514.GA34145@kroah.com>
 <CAMuHMdVWebaq24=cC_LYkxuLMVrSRW3FDohE2CiueUWC15Tm7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVWebaq24=cC_LYkxuLMVrSRW3FDohE2CiueUWC15Tm7A@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 05, 2020 at 01:24:07PM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Sun, Jul 5, 2020 at 8:55 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sat, Jul 04, 2020 at 08:38:26PM +0200, Geert Uytterhoeven wrote:
> > > On Sat, Jul 4, 2020 at 4:05 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > Test the functionality of readfile(2) in various ways.
> > > >
> > > > Also provide a simple speed test program to benchmark using readfile()
> > > > instead of using open()/read()/close().
> > > >
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/readfile/readfile.c
> > >
> > > > +static void readfile(const char *filename)
> > > > +{
> > > > +//     int root_fd;
> > >
> > > ???
> >
> > Ugh, sorry about that, I obviously didn't clean up my last tests from
> > this file, thanks for catching that.
> 
> Reading about seq_file behavior, did the commented-out test for
> "/sys/kernel/debug/usb/devices" work?

Yes it did, which means I need to go dig to try to find a "problem"
seq_file procfs file to try to debug that behavior...

thanks,

greg k-h
