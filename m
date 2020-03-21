Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D0918DD9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Mar 2020 03:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCUC1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 22:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgCUC1T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 22:27:19 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99DE02072C;
        Sat, 21 Mar 2020 02:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584757639;
        bh=nedsngbYpt8dRlE8ouzYmyDgZyehrotze/Me3F8MSxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=go602f2yZ+DooJtVk+Z8ceGqEnFv6+Q1dDI32gMsHchm6raqwPb3zgYHfOc69hz0S
         JgQ6t/LF+8/CHjBumR0jCmOJWkgfmZT87OghXteMXK8GGIGZdX/ckubokV/Wb8mE+v
         NklVAeAm1mhl4z/jTvM+IS6JEPprZa+LnYZ1deJI=
Date:   Fri, 20 Mar 2020 19:27:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v4 0/5] module autoloading fixes and cleanups
Message-Id: <20200320192718.6d90a5a10476626f0e39b166@linux-foundation.org>
In-Reply-To: <20200320052819.GB1315@sol.localdomain>
References: <20200318230515.171692-1-ebiggers@kernel.org>
        <20200320052819.GB1315@sol.localdomain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 19 Mar 2020 22:28:19 -0700 Eric Biggers <ebiggers@kernel.org> wrote:

> It seems that people are relatively happy with this patch series now.
> Andrew, will you be taking it through -mm?  I don't see any better place.

Yup.
