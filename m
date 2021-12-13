Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C073847219F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 08:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhLMHXK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 02:23:10 -0500
Received: from verein.lst.de ([213.95.11.211]:46372 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhLMHXK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:23:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E10BB68AA6; Mon, 13 Dec 2021 08:23:05 +0100 (CET)
Date:   Mon, 13 Dec 2021 08:23:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ramji Jiyani <ramjiyani@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [GIT PULL] aio poll fixes for 5.16-rc5
Message-ID: <20211213072305.GA20423@lst.de>
References: <YbOdV8CPbyPAF234@sol.localdomain> <CAHk-=wh5X0iQ7dDY1joBj0eoZ65rbMb4-v0ewirN1teY8VD=8A@mail.gmail.com> <YbPcFIUFYmEueuXX@sol.localdomain> <YbP0s7E1a5s+6q9B@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbP0s7E1a5s+6q9B@mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 10, 2021 at 07:45:39PM -0500, Theodore Y. Ts'o wrote:
> distributions are compiling them with AIO enabled, since you can get
> better performance with AIO.  Fio also uses AIO, and many fio recipes
> that are trying to benchmark file systems or block devices use
> AIO/DIO.

As does qemu and many commercial databases.
