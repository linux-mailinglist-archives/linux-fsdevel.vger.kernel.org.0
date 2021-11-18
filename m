Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB3B456513
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 22:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhKRVfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 16:35:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230481AbhKRVfS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:35:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24F6E61179;
        Thu, 18 Nov 2021 21:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637271137;
        bh=KD3bI4st4bInSJx58BqiEup1qRmegX6pcoDZrS9IaKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UB8ojPFtzr35tHYZeJ9Vq6Hi9qT1jqBVNPWobFHjTp2FulxEP0daR2Lf0jwBoPfXD
         QgxRhVXKPZWPDapx4x2PkPF6VpkkF36oZQ4abt03PDlP6sm7yi2hduOEIY2Pmwx3Ry
         NMjGUkvTk3zb8P7HGImkPz6iRyNvSUdugWKWqFjg=
Date:   Thu, 18 Nov 2021 13:32:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [regression] mm, cifs panic
Message-Id: <20211118133215.4b8168a062693b32442eb928@linux-foundation.org>
In-Reply-To: <CAH2r5mtW35HzmNDNxPXj1cKiEsyaz45_mcsQmWkTa_orOkS7ug@mail.gmail.com>
References: <20211118042914.wnffm3ytzmxjdubn@xzhoux.usersys.redhat.com>
        <CAH2r5mtW35HzmNDNxPXj1cKiEsyaz45_mcsQmWkTa_orOkS7ug@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Nov 2021 10:18:16 -0600 Steve French <smfrench@gmail.com> wrote:

> Andrew Morton had posted Matthew Wilcox's patch (to fix the recent
> regression in mm/swap.c) in email (on the 9th) to fs-devel titled:
> 
>        "+ hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list.patch"
> 
> The patch was reviewed and verified (tested) to fix the problem but
> has not been merged into mainline.  Various xfstests break without
> this patch.

It's in my next batch of fixes to send to Linus.  Hopefully tomorrow.
