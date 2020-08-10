Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D151524081E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgHJPEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 11:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgHJPEn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:04:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7749520774;
        Mon, 10 Aug 2020 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597071883;
        bh=XrRQjxQ+5hBm9ooxNZUmS5a2TwH3ejiZlRc9kr/rE9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMiLT3vuWKmLrU+59l58LWwIcdYJmu+0zwXBqkXOpLREv3Bin7mG+U5LnwQjNZIKS
         Pu3mCJ0+tcfBcxMKfpatwvKgGTjGQoPbHiziCQlgdUhW+yuU8dl8r+1Rp5q90BdV9q
         m0479Pt+TS3LWP25jpPgZKUC3LWFwldollaQtUxQ=
Date:   Mon, 10 Aug 2020 17:04:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eugene Lubarsky <elubarsky.linux@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        avagin@gmail.com, dsahern@gmail.com
Subject: Re: [RFC PATCH 0/5] Introduce /proc/all/ to gather stats from all
 processes
Message-ID: <20200810150453.GB3962761@kroah.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810145852.9330-1-elubarsky.linux@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:58:47AM +1000, Eugene Lubarsky wrote:
> This is an idea for substantially reducing the number of syscalls needed
> by monitoring tools whilst mostly re-using the existing API.

How many syscalls does this save on?

Perhaps you want my proposed readfile(2) syscall:
	https://lore.kernel.org/r/20200704140250.423345-1-gregkh@linuxfoundation.org
to help out with things like this?  :)

> The proposed files in this proof-of-concept patch set are:
> 
> * /proc/all/stat

I think the problem will be defining "all" in the case of the specific
namespace you are dealing with, right?  How will this handle all of
those issues properly for all of these different statisics?

thanks,

greg k-h
