Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C195A1AB67F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 06:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDPEHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 00:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbgDPEH2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 00:07:28 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C3020767;
        Thu, 16 Apr 2020 04:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587010048;
        bh=5Js663jCMQnnanixbXGlT1h0jEUb3V5uU1s+WTiHyYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FtmA36invyFrgzCq2vyJyaVOVMJLXulhRWuGbEv5CxK6N+hgNugmwsZ1VMlompByA
         yAwdUfOrIn+BgK1fZm2N86xYmiVtyGBc/hgOmqr2OdWBfPqVzTNJ9c+EsB0/u1kxwe
         tY2h4XDhpoDeHiUCHaoJ8kPbncRCBGlM+zmNfv9Y=
Date:   Wed, 15 Apr 2020 21:07:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: rename "catch" function argument
Message-Id: <20200415210727.c0cf80b5a981292bb15d9858@linux-foundation.org>
In-Reply-To: <20200331210905.GA31680@avx2>
References: <20200331210905.GA31680@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 Apr 2020 00:09:05 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> "catch" is reserved keyword in C++, rename it to something
> both gcc and g++ accept.

Why? Is someone compiling the kernel with g++?

> Rename "ign" for symmetry.
> 
> Signed-off-by: _Z6Alexeyv <adobriyan@gmail.com>

Was this intentional?
