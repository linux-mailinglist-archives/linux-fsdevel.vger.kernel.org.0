Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1941B1B87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 04:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDUCBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 22:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDUCBp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:01:45 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A25C2070B;
        Tue, 21 Apr 2020 02:01:44 +0000 (UTC)
Date:   Mon, 20 Apr 2020 22:01:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 14/15] print_integer, printf: rewrite the rest of
 lib/vsprintf.c via print_integer()
Message-ID: <20200420220142.5c79a0fd@oasis.local.home>
In-Reply-To: <20200420205743.19964-14-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
        <20200420205743.19964-14-adobriyan@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Apr 2020 23:57:42 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Lookup tables are cheating.

But damn fast!


> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
>

 NACK!

-- Steve
