Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279BF41F846
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Oct 2021 01:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhJAXlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 19:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230368AbhJAXlQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 19:41:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91E4C619F5;
        Fri,  1 Oct 2021 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1633131571;
        bh=deaurehqMN/DfBhFHASQPAcnai0N7/DCFk9nAG4JSVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T7PFE7BR1bGHU6uRDqm/dH/MqG3pshEvnpe3K+tEmyxQOQZq3fRyG/sIA7fdE7kYF
         2ergbf/D18Np1m6iDONjkyabmCG6W9p/VmEu6OgfzXgdt1nOi0LwbFQ3nxKX9jSubk
         lpCtQS29yw2sghL1BdKHpI0fBWrgZS9ZTXkctP+8=
Date:   Fri, 1 Oct 2021 16:39:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, jic23@kernel.org
Subject: Re: [PATCH v1 1/1] seq_file: Move seq_escape() to a header
Message-Id: <20211001163931.e3bb7bf5a401fa982fda5bb2@linux-foundation.org>
In-Reply-To: <20211001122917.67228-1-andriy.shevchenko@linux.intel.com>
References: <20211001122917.67228-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  1 Oct 2021 15:29:17 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Move seq_escape() to the header as inliner.

Some reason for doing this would be nice.  Does it make the kernel
smaller?  Is this performance-sensitive?

> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/string.h>
> +#include <linux/string_helpers.h>

Why was this added?

>  #include <linux/bug.h>
>  #include <linux/mutex.h>
>  #include <linux/cpumask.h>

