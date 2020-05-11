Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFC21CD685
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgEKK21 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 06:28:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:45094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgEKK20 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 06:28:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A679DAD11;
        Mon, 11 May 2020 10:28:27 +0000 (UTC)
Subject: Re: [PATCH] kernel/watchdog.c: convert {soft/hard}lockup boot
 parameters to sysctl aliases
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, mcgrof@kernel.org, kernel@gpiccoli.net
References: <20200507214624.21911-1-gpiccoli@canonical.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <03d35861-85c0-4a28-4845-02add0671351@suse.cz>
Date:   Mon, 11 May 2020 12:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507214624.21911-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/7/20 11:46 PM, Guilherme G. Piccoli wrote:
> After a recent change introduced by Vlastimil's series [0], kernel is
> able now to handle sysctl parameters on kernel command line; also, the
> series introduced a simple infrastructure to convert legacy boot
> parameters (that duplicate sysctls) into sysctl aliases.
> 
> This patch converts the watchdog parameters softlockup_panic and
> {hard,soft}lockup_all_cpu_backtrace to use the new alias infrastructure.
> It fixes the documentation too, since the alias only accepts values 0
> or 1, not the full range of integers. We also took the opportunity here
> to improve the documentation of the previously converted hung_task_panic
> (see the patch series [0]) and put the alias table in alphabetical order.
> 
> [0] lore.kernel.org/lkml/20200427180433.7029-1-vbabka@suse.cz
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

Ah, so I did miss some, as the Documentation file doesn't mention there is also
a sysctl for those parameters. Maybe it should?

Anyway, thanks.
Acked-by: Vlastimil Babka <vbabka@suse.cz>
