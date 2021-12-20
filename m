Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9C447A9C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Dec 2021 13:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhLTMis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Dec 2021 07:38:48 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:36608 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhLTMir (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fX8aLO7bG6Mm38H7q0aoXpd//d9kXKKfvCn5eQeXOvU=; b=kZJtj+YT+YliPtcEGEpBJX7J1e
        o1nCj49tqM1w2FX0nNXyjmhtf3vpx72RcgrYINyJsUpu79d4B2lN0hX/w0U40ZYybPRPhG3lC84wy
        vxWu9Q40xtyngmBbHgGSFyK+IX5Lwwjh16baw9Hkan5Xq/C18dvRe0UPtDWSqXYAwttvAiXe9HVP7
        x0QC+ure8ARnwxm6jEE5QmZRudMcY49iyKIhTCbdSft/YdaK0X9ATqQrlmrZn5dy7cJaSiQ7MD+mo
        wmJ453A7jdx8xwYmS5dgrLcd7cUT04KNvPgqAtUakC0rkDhWcDU/Lz8+/O9w8rnffqe5jRguqU+Mr
        u1fklFww==;
Received: from [177.103.99.151] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1mzHw7-00037r-8H; Mon, 20 Dec 2021 13:38:39 +0100
Subject: Re: [PATCH 2/3] panic: Add option to dump all CPUs backtraces in
 panic_print
To:     Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org
Cc:     Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        keescook@chromium.org, yzaikin@google.com, siglesias@igalia.com,
        kernel@gpiccoli.net
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-3-gpiccoli@igalia.com>
 <20211130051206.GB89318@shbuild999.sh.intel.com>
 <6f269857-2cbe-b4dd-714a-82372dc3adfc@igalia.com>
 <Yb+R/OVeBkdYLWeH@bombadil.infradead.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <911e81d3-5ffe-b936-f668-bf1f6a9b6cfb@igalia.com>
Date:   Mon, 20 Dec 2021 09:38:23 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yb+R/OVeBkdYLWeH@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/12/2021 17:11, Luis Chamberlain wrote:
> mcgrof@sumo ~/linux-next (git::master)$ ./scripts/get_maintainer.pl
> kernel/printk/
> Petr Mladek <pmladek@suse.com> (maintainer:PRINTK)
> Sergey Senozhatsky <senozhatsky@chromium.org> (maintainer:PRINTK)
> Steven Rostedt <rostedt@goodmis.org> (reviewer:PRINTK)
> John Ogness <john.ogness@linutronix.de> (reviewer:PRINTK)
> linux-kernel@vger.kernel.org (open list)    
> 
> So I suggest you email the patches to those.
> 
>   Luis
> 

Hi Luis, thank you! But I confess I'm very confused with this series. I
saw emails from Andrew that the patches had been accepted and were
available in -mm tree ([0] for example) but I'm not seeing them in
linux-next nor mmotm/mmots (although I saw them in mmotm directory for a
while before).

Andrew, could you clarify the state of them?
Appreciate that!

Cheers,


Guilherme


[0]
https://lore.kernel.org/mm-commits/20211214182909._sQRtXv89%25akpm@linux-foundation.org/
