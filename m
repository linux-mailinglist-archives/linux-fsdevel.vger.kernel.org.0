Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0639425666E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 11:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgH2JYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 05:24:11 -0400
Received: from verein.lst.de ([213.95.11.211]:44190 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgH2JYJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 05:24:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DDC8268C4E; Sat, 29 Aug 2020 11:24:06 +0200 (CEST)
Date:   Sat, 29 Aug 2020 11:24:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/10] lkdtm: disable set_fs-based tests for
 !CONFIG_SET_FS
Message-ID: <20200829092406.GB8833@lst.de>
References: <20200827150030.282762-1-hch@lst.de> <20200827150030.282762-6-hch@lst.de> <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:06:28AM -0700, Linus Torvalds wrote:
> On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Once we can't manipulate the address limit, we also can't test what
> > happens when the manipulation is abused.
> 
> Just remove these tests entirely.
> 
> Once set_fs() doesn't exist on x86, the tests no longer make any sense
> what-so-ever, because test coverage will be basically zero.
> 
> So don't make the code uglier just to maintain a fiction that
> something is tested when it isn't really.

Sure fine with me unless Kees screams.
