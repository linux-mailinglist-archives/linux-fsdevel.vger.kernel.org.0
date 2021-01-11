Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA802F1DA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 19:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbhAKSLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 13:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389089AbhAKSLB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:11:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2743E223C8;
        Mon, 11 Jan 2021 18:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610388620;
        bh=8uVTG7H/H6en2wkgb810V2bNz2WHFjyuMPJMC7Dzlyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fic++flJROPHX43lCcMJWpDsxZjBLkT1J4s3liytrxCPrv6rGumnaA4iP6+K+6tUf
         JQY0mmFPUAzyZCTJk711oCKraNouq4VqTj+WyzqpEvTUd6Zfsix794dxWrpzeP+r2H
         NpNRqujd1N6DkiuPlcCIRHwhvrzhdzPtmiixbUGo=
Date:   Mon, 11 Jan 2021 19:10:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] char_dev: replace cdev_map with an xarray
Message-ID: <X/yUiALB921A/Z2Y@kroah.com>
References: <20210111170513.1526780-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111170513.1526780-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 06:05:13PM +0100, Christoph Hellwig wrote:
> None of the complicated overlapping regions bits of the kobj_map are
> required for the character device lookup, so just a trivial xarray
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for doing this!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
