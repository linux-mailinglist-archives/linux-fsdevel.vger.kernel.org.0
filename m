Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA57423450
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 01:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhJEXON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 19:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237116AbhJEXOE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:14:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A022F6120F;
        Tue,  5 Oct 2021 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633475533;
        bh=T/bZEpCtpvKA+fHkxUNcnFD9ofzDyhj0b6N+W6min7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0RCqYTNpGE/yA1iyqa/SkDF+BlHS0hSyQ7fHH9wMsguKHXDmy/V8sG4jXILo0bKAz
         i012rMgkOu6nrjNEVqK8eEPn0R9MW37H5+d5T5PKCxUY9yDWquJdxj9UcecYEc1e1S
         TSU2TSmXAPjYauIcI3gvyhC5IMjIZgSSQJqvc7NI=
Date:   Tue, 5 Oct 2021 16:12:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Chen Jingwen <chenjingwen6@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Andrei Vagin <avagin@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] elf: don't use MAP_FIXED_NOREPLACE for elf interpreter
 mappings
Message-Id: <20211005161212.2eb4ca912d131e72bf09bdd6@linux-foundation.org>
In-Reply-To: <202110041255.83A6616D9@keescook>
References: <20210928125657.153293-1-chenjingwen6@huawei.com>
        <202110041255.83A6616D9@keescook>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 4 Oct 2021 13:00:07 -0700 Kees Cook <keescook@chromium.org> wrote:

> Andrew, are you able to pick up [1], BTW? It seems to have fallen
> through the cracks.
> 
> [1] https://lore.kernel.org/all/20210916215947.3993776-1-keescook@chromium.org/T/#u

I added that to -mm on 19 September.:
https://ozlabs.org/~akpm/mmotm/broken-out/binfmt_elf-reintroduce-using-map_fixed_noreplace.patch
