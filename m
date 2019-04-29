Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14295EBD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 22:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfD2UsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 16:48:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:43574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbfD2UsD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:48:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 650C3ADF0;
        Mon, 29 Apr 2019 20:48:02 +0000 (UTC)
Date:   Mon, 29 Apr 2019 13:47:54 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Eric Wong <e@80x24.org>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Omar Kilani <omar.kilani@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Strange issues with epoll since 5.0
Message-ID: <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
References: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
 <20190424193903.swlfmfuo6cqnpkwa@dcvr>
 <20190427093319.sgicqik2oqkez3wk@dcvr>
 <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
 <20190428004858.el3yk6hljloeoxza@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190428004858.el3yk6hljloeoxza@dcvr>
User-Agent: NeoMutt/20180323
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 28 Apr 2019, Eric Wong wrote:

>Just running one test won't trigger since it needs a busy
>machine; but:
>
>	make test/mgmt_auto_adjust.log
>	(and "rm make test/mgmt_auto_adjust.log" if you want to rerun)

fyi no luck reproducing on both either a large (280) or small (4 cpu)
machine, I'm running it along with a kernel build overcommiting cpus x2.

Is there any workload in particular you are using to stress the box?

Thanks,
Davidlohr
