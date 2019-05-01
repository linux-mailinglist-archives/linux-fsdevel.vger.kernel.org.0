Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9523105E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 09:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfEAHjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 03:39:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43340 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfEAHjH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 03:39:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 98E9F1F453;
        Wed,  1 May 2019 07:39:06 +0000 (UTC)
Date:   Wed, 1 May 2019 07:39:06 +0000
From:   Eric Wong <e@80x24.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Omar Kilani <omar.kilani@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Strange issues with epoll since 5.0
Message-ID: <20190501073906.ekqr7xbw3qkfgv56@dcvr>
References: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
 <20190424193903.swlfmfuo6cqnpkwa@dcvr>
 <20190427093319.sgicqik2oqkez3wk@dcvr>
 <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
 <20190428004858.el3yk6hljloeoxza@dcvr>
 <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
 <20190429210427.dmfemfft2t2gdwko@dcvr>
 <CABeXuvqpAjk8ocRUabVU4Yviv7kgRkMneLE1Xy-jAtHdXAHBVw@mail.gmail.com>
 <20190501021405.hfvd7ps623liu25i@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190501021405.hfvd7ps623liu25i@dcvr>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> (didn't test AIO, but everything else seems good)

"seems" != "is"

Now that I understand the fix for epoll, the fs/select.c changes
would hit the same problem and not return -EINTR when it should.

I'll let you guys decide how to fix this, but there's definitely
a problem when "(errno == EINTR)" comparisons in userspace
stop working.
