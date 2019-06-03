Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2EE32916
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 09:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfFCHF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 03:05:56 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:33981 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfFCHFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:05:55 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 4D6CA1C0002;
        Mon,  3 Jun 2019 07:05:37 +0000 (UTC)
Subject: Re: [PATCH v4 05/14] arm64, mm: Make randomization selected by
 generic topdown mmap layout
To:     Christoph Hellwig <hch@lst.de>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Burton <paul.burton@mips.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20190526134746.9315-1-alex@ghiti.fr>
 <20190526134746.9315-6-alex@ghiti.fr> <20190601090437.GF6453@lst.de>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <211c4d0b-ec11-c94e-8a7f-9564e7905f50@ghiti.fr>
Date:   Mon, 3 Jun 2019 09:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190601090437.GF6453@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/1/19 11:04 AM, Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>


Thanks for your time,

Alex


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
