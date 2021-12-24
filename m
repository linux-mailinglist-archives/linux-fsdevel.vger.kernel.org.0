Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED047EC63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 08:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351694AbhLXHC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 02:02:59 -0500
Received: from verein.lst.de ([213.95.11.211]:55883 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245714AbhLXHC7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 02:02:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6EC1E68BEB; Fri, 24 Dec 2021 08:02:51 +0100 (CET)
Date:   Fri, 24 Dec 2021 08:02:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 01/13] mm: remove cleancache
Message-ID: <20211224070250.GA13081@lst.de>
References: <20211224062246.1258487-1-hch@lst.de> <20211224062246.1258487-2-hch@lst.de> <a8c126f4-c8b2-0f19-eb54-977dd3dae90d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c126f4-c8b2-0f19-eb54-977dd3dae90d@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 24, 2021 at 08:01:32AM +0100, Juergen Gross wrote:
> On 24.12.21 07:22, Christoph Hellwig wrote:
>> The cleancache subsystem is unused since the removal of Xen tmem driver
>> in commit 814bbf49dcd0 ("xen: remove tmem driver").
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Hehe, this is nearly a verbatim copy of the patch I sent in 2019 (I only
> missed the defconfig parts back then):
>
> https://lore.kernel.org/lkml/20190527103207.13287-3-jgross@suse.com/
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

I'm perfectly fine with changing the attribution to your here a well.
