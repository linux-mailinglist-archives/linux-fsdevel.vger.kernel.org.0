Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FCD19F654
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 15:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgDFNCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 09:02:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53142 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbgDFNCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:02:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLROg-00CA1y-Gz; Mon, 06 Apr 2020 13:02:38 +0000
Date:   Mon, 6 Apr 2020 14:02:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] binfmt_elf: remove the set_fs(KERNEL_DS) in
 elf_core_dump
Message-ID: <20200406130238.GT23230@ZenIV.linux.org.uk>
References: <20200406120312.1150405-1-hch@lst.de>
 <20200406120312.1150405-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406120312.1150405-4-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:03:09PM +0200, Christoph Hellwig wrote:
> There is no logic in elf_core_dump itself that uses uaccess routines
> on kernel pointers, the file writes are nicely encapsulated in dump_emit
> which does its own set_fs.

... assuming you've checked the asm/elf.h to see that nobody is playing
silly buggers in these forests of macros and the stuff called from those.
Which is a feat that ought to be mentioned in commit message...
