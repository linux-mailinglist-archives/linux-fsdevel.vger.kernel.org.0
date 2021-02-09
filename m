Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB6431594C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 23:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhBIWVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 17:21:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233983AbhBIWMQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:12:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83C3264EDB;
        Tue,  9 Feb 2021 21:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1612907919;
        bh=3OazZLnMyWfzCFzoLzcmJx+KxLTa7Ra6qrPelD5PAJc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l4OVeW6UO3eZoL6HdhnLEntkfsJha1QB0Hp3JUXgAmjhCkCRQJbRtIuNUfAopYcAP
         iKHbxIeIejc4/QlW3XVUd6L0ItJLgOIunN9QXjyxizis4aHpxAoUSnVS4gKGlKYZHi
         SyxhdbawLDcAUoTnpY4g/cvV9GR6ocECy3THL5A0=
Date:   Tue, 9 Feb 2021 13:58:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/4] btrfs: Convert kmaps to core page calls
Message-Id: <20210209135837.055cfd1df4e5829f2da6b062@linux-foundation.org>
In-Reply-To: <20210209215229.GC2975576@iweiny-DESK2.sc.intel.com>
References: <20210205232304.1670522-1-ira.weiny@intel.com>
        <20210209151123.GT1993@suse.cz>
        <20210209110931.00f00e47d9a0529fcee2ff01@linux-foundation.org>
        <20210209205249.GB2975576@iweiny-DESK2.sc.intel.com>
        <20210209131103.b46e80db675fec8bec8d2ad1@linux-foundation.org>
        <20210209215229.GC2975576@iweiny-DESK2.sc.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 9 Feb 2021 13:52:29 -0800 Ira Weiny <ira.weiny@intel.com> wrote:

> > 
> > Let's please queue this up separately.
> 
> Ok can I retain your Ack on the move part of the patch?

I missed that.

>  Note that it does change kmap_atomic() to kmap_local_page() currently.
> 
> Would you prefer a separate change for that as well?

Really that should be separated out as well, coming after the move, to
make it more easily reverted.  With a standalone changlog for this.

All a bit of a pain, but it's best in the long run.
