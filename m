Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9726C4843A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 15:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiADOqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 09:46:47 -0500
Received: from verein.lst.de ([213.95.11.211]:50184 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232977AbiADOqr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:46:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E84468AFE; Tue,  4 Jan 2022 15:46:43 +0100 (CET)
Date:   Tue, 4 Jan 2022 15:46:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Hildenbrand <david@redhat.com>
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
Subject: Re: remove Xen tmem leftovers
Message-ID: <20220104144642.GA23411@lst.de>
References: <20211224062246.1258487-1-hch@lst.de> <10ec73d4-6658-4f60-abe1-84ece53ca373@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10ec73d4-6658-4f60-abe1-84ece53ca373@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:31:20PM +0100, David Hildenbrand wrote:
> Just out of curiosity, why was tmem removed from Linux (or even Xen?).
> Do you have any information?

"The Xen tmem (transcendent memory) driver can be removed, as the
 related Xen hypervisor feature never made it past the "experimental"
 state and will be removed in future Xen versions (>= 4.13).
	    
 The xen-selfballoon driver depends on tmem, so it can be
 removed, too."
