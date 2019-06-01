Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7031AB2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2019 11:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFAJFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Jun 2019 05:05:03 -0400
Received: from verein.lst.de ([213.95.11.211]:45999 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfFAJFD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jun 2019 05:05:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5A06068AFE; Sat,  1 Jun 2019 11:04:37 +0200 (CEST)
Date:   Sat, 1 Jun 2019 11:04:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 05/14] arm64, mm: Make randomization selected by
 generic topdown mmap layout
Message-ID: <20190601090437.GF6453@lst.de>
References: <20190526134746.9315-1-alex@ghiti.fr> <20190526134746.9315-6-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526134746.9315-6-alex@ghiti.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
