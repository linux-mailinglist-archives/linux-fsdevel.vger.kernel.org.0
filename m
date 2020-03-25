Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30AFC192428
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 10:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCYJdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 05:33:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:58424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgCYJdS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:33:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7C6CEAAFD;
        Wed, 25 Mar 2020 09:33:15 +0000 (UTC)
Subject: Re: [PATCH V2] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
To:     Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org, yzaikin@google.com,
        tglx@linutronix.de, penguin-kernel@I-love.SAKURA.ne.jp,
        akpm@linux-foundation.org, cocci@systeme.lip6.fr,
        linux-api@vger.kernel.org, kernel@gpiccoli.net,
        randy Dunlap <rdunlap@infradead.org>
References: <20200323214618.28429-1-gpiccoli@canonical.com>
 <b73a6519-0529-e36f-fac5-e4b638ceb3cf@suse.cz>
 <eee335a2-e673-39bf-ae64-e49c66f74255@canonical.com>
 <202003241119.A666E1C694@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9eab7f80-bad4-bcb1-7ec7-b6b90839b13a@suse.cz>
Date:   Wed, 25 Mar 2020 10:33:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <202003241119.A666E1C694@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/24/20 7:20 PM, Kees Cook wrote:
> On Tue, Mar 24, 2020 at 09:45:40AM -0300, Guilherme G. Piccoli wrote:
>> Thanks Randy and Vlastimil for the comments. I really liked your
>> approach Vlastimil, I agree that we have no reason to not have a generic
>> sysctl setting via cmdline mechanism - I'll rework this patch removing
>> the kernel parameter (same for other patch I just submitted).
> 
> I've been thinking we'll likely want to have a big patch series that
> removes all the old "duplicate" boot params and adds some kind of
> "alias" mechanism.
> 
> Vlastimil, have you happened to keep a list of other "redundant" boot
> params you've noticed in the kernel? I bet there are a lot. :)

Well, I found about 4 that mentioned sysctl in
Documentation/admin-guide/kernel-parameters.txt
I suspect there will be more, but won't be trivial to identify them.


