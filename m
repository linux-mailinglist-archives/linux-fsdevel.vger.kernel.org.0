Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5AC1F6A8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgFKPEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 11:04:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48131 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728419AbgFKPEP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:04:15 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 05BF3eIm026407
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 11:03:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0903E4200DD; Thu, 11 Jun 2020 11:03:40 -0400 (EDT)
Date:   Thu, 11 Jun 2020 11:03:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        jack@suse.com, Hillf Danton <hdanton@sina.com>,
        linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
Subject: Re: [PATCHv2 1/1] ext4: mballoc: Use this_cpu_read instead of
 this_cpu_ptr
Message-ID: <20200611150340.GP1347934@mit.edu>
References: <534f275016296996f54ecf65168bb3392b6f653d.1591699601.git.riteshh@linux.ibm.com>
 <20200610062538.GA24975@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610062538.GA24975@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:25:38PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 09, 2020 at 04:23:10PM +0530, Ritesh Harjani wrote:
> > Simplify reading a seq variable by directly using this_cpu_read API
> > instead of doing this_cpu_ptr and then dereferencing it.
> > 
> > This also avoid the below kernel BUG: which happens when
> > CONFIG_DEBUG_PREEMPT is enabled
> 
> I see this warning all the time with ext4 using tests VMs, so lets get
> this fixed ASAP before -rc1:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, applied.

						- Ted
