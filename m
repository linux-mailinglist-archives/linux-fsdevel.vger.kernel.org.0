Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9025D7078
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 09:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfJOHso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 03:48:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:46382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbfJOHso (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 03:48:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC376B657;
        Tue, 15 Oct 2019 07:48:41 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Atish Patra <Atish.Patra@wdc.com>
Cc:     "alex\@ghiti.fr" <alex@ghiti.fr>,
        "aou\@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "keescook\@chromium.org" <keescook@chromium.org>,
        "jhogan\@kernel.org" <jhogan@kernel.org>,
        "catalin.marinas\@arm.com" <catalin.marinas@arm.com>,
        "palmer\@sifive.com" <palmer@sifive.com>,
        "will.deacon\@arm.com" <will.deacon@arm.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf\@linux-mips.org" <ralf@linux-mips.org>,
        "linux\@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-mm\@kvack.org" <linux-mm@kvack.org>,
        "paul.burton\@mips.com" <paul.burton@mips.com>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "viro\@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "paul.walmsley\@sifive.com" <paul.walmsley@sifive.com>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch\@lst.de" <hch@lst.de>, linux-arm-kernel@lists.infr
Subject: Re: [PATCH v6 14/14] riscv: Make mmap allocation top-down by default
References: <20190808061756.19712-1-alex@ghiti.fr>
        <20190808061756.19712-15-alex@ghiti.fr>
        <208433f810b5b07b1e679d7eedb028697dff851b.camel@wdc.com>
        <60b52f20-a2c7-dee9-7cf3-a727f07400b9@ghiti.fr>
        <daeb33415751ef16a717f6ff6a29486110c503d7.camel@wdc.com>
        <9e9a3fea-d8a3-ae62-317a-740773f0725c@ghiti.fr>
        <d9bc696aa9d1e306e4cff04a2926b0faa2dc5587.camel@wdc.com>
        <4192e5ef-2e9c-950c-1899-ee8ce9a05ec3@ghiti.fr>
        <d27c8eac16d1cc4d5ca139802b4d0cdd2dbbca11.camel@wdc.com>
X-Yow:  BARBARA STANWYCK makes me nervous!!
Date:   Tue, 15 Oct 2019 09:48:40 +0200
In-Reply-To: <d27c8eac16d1cc4d5ca139802b4d0cdd2dbbca11.camel@wdc.com> (Atish
        Patra's message of "Tue, 15 Oct 2019 00:31:37 +0000")
Message-ID: <mvmv9sqfnzb.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Okt 15 2019, Atish Patra <Atish.Patra@wdc.com> wrote:

> Nope. This is only reproducible in RISC-V Fedora Gnome desktop image on
> a HiFive Unleashed + Microsemi Expansion. Just to clarify, there is no
> issue with OpenEmbedded disk image related to memory layout. It was a
> userspace thing.

Does it also happen with any of the openSUSE images?

https://download.opensuse.org/ports/riscv/tumbleweed/images/

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
