Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244874A5D60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 14:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbiBANYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 08:24:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38382 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238453AbiBANYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:24:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0221DB82DE3
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Feb 2022 13:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEA3C340ED;
        Tue,  1 Feb 2022 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643721852;
        bh=K0sZoK+fLiW8occ9XFUjz1BylsuZ2lAHxd5nVMgf33k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/UGWrcG3zi5TfcaCpmJ283xmGXrGtYxzHhBs+0v+OY+RoJ9dDc3fzpDhG03iv3Hv
         UsfRKhO4cESGWYzoDaSBDee/poIS2nJKpNirAFJvt2b3Qaknzc3XeLyTByC85fcaEk
         IrlAjcdKTaa9hT6NOhSXoqe9Q1fYCANCvBfWoHMbsNVfWHT/zGfaSuWmeUYjl2Ms2y
         tVONaG3wM71oNz28O+Hg4N0KUhboSR5W82AekZaGgHpN8N8tOnqlojxLQ+DQh6OXrG
         zYYmaek4AvrdEB0SCU+iU+/xiMS3ZvB2g9n9j6A9TV78B+TAxa+cw71Jyr/ZAiYlq1
         FWfBDb+aRtPRw==
Date:   Tue, 1 Feb 2022 14:24:03 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        jlayton@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Netfs support library
Message-ID: <20220201132403.cfyfwn4zn4jyldnu@wittgenstein>
References: <2571706.1643663173@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2571706.1643663173@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 09:06:13PM +0000, David Howells wrote:
> I've been working on a library (in fs/netfs/) to provide network filesystem
> support services, with help particularly from Jeff Layton.  The idea is to
> move the common features of the VM interface, including request splitting,
> operation retrying, local caching, content encryption, bounce buffering and
> compression into one place so that various filesystems can share it.
> 
> This also intersects with the folios topic as one of the reasons for this now
> is to hide as much of the existence of folios/pages from the filesystem,
> instead giving it persistent iov iterators to describe the buffers available
> to it.
> 
> It could be useful to get various network filesystem maintainers together to
> discuss it and how to do parts of it and how to roll it out into more
> filesystems if it suits them.  This might qualify more for a BoF session than
> a full FS track session.
> 
> Further, discussion of designing a more effective cache backend could be
> useful.  I'm thinking along the lines of something that can store its data on
> a single file (or a raw blockdev) with indexing along the lines of what
> filesystem drivers such as openafs do.

I do have some interest in this area as well so would like to attend
that session.

Christian
