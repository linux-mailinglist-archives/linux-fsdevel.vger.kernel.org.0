Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75EF42D4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 19:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407217AbfFLRR4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 13:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726696AbfFLRR4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:17:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA37B21019;
        Wed, 12 Jun 2019 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560359875;
        bh=vxqF9i347DTWTMKqqdYqSDf/C++Fm/stVuKn+tORbuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBJjBJYExZEyVmASDWyZF2x4VdFFOW/hSnvee/WVTDhYkhMGu9jm+69s/LwDwhxDG
         wId+ydyxjw+77nO0g1NFfKu1llq977Uyv2NBFYg9aWkSNnVGogS9hfG67v2ptuyRps
         0fNda+ZXxHdZ6tV5SsjvJORQ+659JKQmIsdSQnvQ=
Date:   Wed, 12 Jun 2019 19:17:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Subject: Re: [PATCH 11/12] closures: closure_wait_event()
Message-ID: <20190612171753.GB7518@kroah.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <20190610191420.27007-12-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610191420.27007-12-kent.overstreet@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 03:14:19PM -0400, Kent Overstreet wrote:
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  include/linux/closure.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Again, no changelog?  You are a daring developer... :)

greg k-h
