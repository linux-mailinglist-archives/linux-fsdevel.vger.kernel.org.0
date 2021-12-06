Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD046998D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbhLFO55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 09:57:57 -0500
Received: from verein.lst.de ([213.95.11.211]:50940 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344728AbhLFO54 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:57:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8473E68AFE; Mon,  6 Dec 2021 15:54:23 +0100 (CET)
Date:   Mon, 6 Dec 2021 15:54:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kexec <kexec@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 01/14] fs/proc/vmcore: Update read_from_oldmem()
 for user pointer
Message-ID: <20211206145422.GA8794@lst.de>
References: <20211203104231.17597-1-amit.kachhap@arm.com> <20211203104231.17597-2-amit.kachhap@arm.com> <20211206140451.GA4936@lst.de> <Ya4bdB0UBJCZhUSo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya4bdB0UBJCZhUSo@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 02:17:24PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 06, 2021 at 03:04:51PM +0100, Christoph Hellwig wrote:
> > This looks like a huge mess.  What speak against using an iov_iter
> > here?
> 
> I coincidentally made a start on this last night.  Happy to stop.

Don't stop!

> What do you think to adding a generic copy_pfn_to_iter()?  Not sure
> which APIs to use to implement it ... some architectures have weird
> requirements about which APIs can be used for what kinds of PFNs.

Hmm.  I though kmap_local_pfn(_prot) is all we need?
