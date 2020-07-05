Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64A214ABA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 08:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgGEGzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 02:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgGEGzR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:55:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD96B20771;
        Sun,  5 Jul 2020 06:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593932117;
        bh=kBMlJanR1enACjjFDoR+XJ5J4RiDm9o74tcWF6LEt+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wb3qZj3CnNZxBoPTvh7p6HB4/tGtTeV11dCiNMA1QWiwXZ2N8IyhuogdQUhlLNNOM
         NIKiy3C/HWOmNGuLmp3EhGI3R+XOAb15g4SCDejhGdQtisAf+WdoRNr55sAUXGCLNp
         J57TWI3lwdht4d84rQIRhIZ/Vh79TiUzX71QFP1o=
Date:   Sun, 5 Jul 2020 08:55:14 +0200
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
Message-ID: <20200705065514.GA34145@kroah.com>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
 <20200704140250.423345-4-gregkh@linuxfoundation.org>
 <CAMuHMdXck1u+Djv1xOvRA7riMN4m3qp8o4zmXVvqrC1S+0fifA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXck1u+Djv1xOvRA7riMN4m3qp8o4zmXVvqrC1S+0fifA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 04, 2020 at 08:38:26PM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Sat, Jul 4, 2020 at 4:05 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Test the functionality of readfile(2) in various ways.
> >
> > Also provide a simple speed test program to benchmark using readfile()
> > instead of using open()/read()/close().
> >
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Any benchmark results to share?

Yes, the readfile_speed.c file will show you that on your machine, I'll
post the results of that for two of my machines when I send the next
version of this patch series.

> 
> > --- /dev/null
> > +++ b/tools/testing/selftests/readfile/readfile.c
> 
> > +static void readfile(const char *filename)
> > +{
> > +//     int root_fd;
> 
> ???

Ugh, sorry about that, I obviously didn't clean up my last tests from
this file, thanks for catching that.

I should add more tests to validate the flag handling as well, will do
all of that for the next version, thanks for noticing this.

greg k-h
