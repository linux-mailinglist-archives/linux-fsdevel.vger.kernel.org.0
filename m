Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7610578FFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 17:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfG2P7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 11:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388307AbfG2P7P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:59:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 218813082141;
        Mon, 29 Jul 2019 15:59:15 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A1B86013A;
        Mon, 29 Jul 2019 15:59:14 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "zhangyi \(F\)" <yi.zhang@huawei.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcrl@kvack.org, wangkefeng.wang@huawei.com
Subject: Re: [PATCH] aio: add timeout validity check for io_[p]getevents
References: <1564039289-7672-1-git-send-email-yi.zhang@huawei.com>
        <x49imrqb2e5.fsf@segfault.boston.devel.redhat.com>
        <x49y30gnb16.fsf@segfault.boston.devel.redhat.com>
        <20190729154720.GS1131@ZenIV.linux.org.uk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 29 Jul 2019 11:59:13 -0400
In-Reply-To: <20190729154720.GS1131@ZenIV.linux.org.uk> (Al Viro's message of
        "Mon, 29 Jul 2019 16:47:20 +0100")
Message-ID: <x49h874n86m.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 29 Jul 2019 15:59:15 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Jul 29, 2019 at 10:57:41AM -0400, Jeff Moyer wrote:
>> Al, can you take this through your tree?
>
> Umm...  Can do, but I had an impression that Arnd and Deepa
> had a tree for timespec-related work.  OTOH, it had been
> relatively quiet last cycle, so...  If they have nothing
> in the area, I can take it through vfs.git.

Hmm, okay.  Yi, can you repost the patch, adding my Reviewed-by tag, and
CC-ing Arnd and Deepa:

Arnd Bergmann <arnd@arndb.de>
Deepa Dinamani <deepa.kernel@gmail.com>

Thanks!
Jeff
