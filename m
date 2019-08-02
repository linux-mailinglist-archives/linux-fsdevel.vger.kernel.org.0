Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376E17FCDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390164AbfHBOy1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 10:54:27 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:52100 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfHBOy1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1564757666;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=z+KAYvssR654xT1PJmIJ3CS5+fx3UQzQRMe7cbSlSqs=;
        b=GkFK9XVPajmUrXiNorqYyeXjnb5kxq4Cb7xBG5EVT9qDBnmqPCxH/Q4RMGLw6oDT
        woH5I+acrCTkrFsP9K97B+S3gYciANlTIcTOKxu6QVxVDhvsvig0tH2wb9qGN7pVOWQ
        v11bHmqsvgx+cmakvLlTN7O9cMKuaG6z3jCKUZYw=
Date:   Fri, 2 Aug 2019 14:54:26 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Wilcox <willy@infradead.org>
cc:     linux-fsdevel@vger.kernel.org, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 0/2] iomap & xfs support for large pages
In-Reply-To: <20190731171734.21601-1-willy@infradead.org>
Message-ID: <0100016c52d32b18-8593625f-bf32-4005-be04-79af900ac112-000000@email.amazonses.com>
References: <20190731171734.21601-1-willy@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.08.02-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 31 Jul 2019, Matthew Wilcox wrote:

> Christoph sent me a patch a few months ago called "XFS THP wip".
> I've redone it based on current linus tree, plus the page_size() /
> compound_nr() / page_shift() patches currently found in -mm.  I fixed
> the logic bugs that I noticed in his patch and may have introduced some
> of my own.  I have only compile tested this code.

Some references here to patches from a long time ago. Maybe there are
useful tidbits here ...

Variable page cache just for ramfs:
https://lkml.org/lkml/2007/4/19/261

Large blocksize support for XFS, ReiserFS and ext2
https://www.mail-archive.com/linux-fsdevel@vger.kernel.org/msg08730.html

