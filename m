Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE4522F5BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgG0QsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:39908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgG0QsK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:48:10 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8907F20729;
        Mon, 27 Jul 2020 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595868490;
        bh=z/5/6V/TuwXjZzX6ljD8ivcaP6uk1DXs+P2lUKBx/w8=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=2lDsxkRcDWD8PKN2P45Id2zyrVnpGDpSQYUSDF87fFeRozhhap6SaQkJusXVCOjPY
         N9wVuEF/DREKIM9ZsMcJdPq6W3PZ7DDZscNIipgWFO/lAEIUfBtIUNEovzpLhxb0Uu
         VSCxTIlqnE08xyjybQDpiCnQcFHw1TGm9XZNuqFo=
Date:   Mon, 27 Jul 2020 09:48:09 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs: define inode flags using bit numbers
Message-ID: <20200727164809.GG1138@sol.localdomain>
References: <20200713030952.192348-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713030952.192348-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 12, 2020 at 08:09:52PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Define the VFS inode flags using bit numbers instead of hardcoding
> powers of 2, which has become unwieldy now that we're up to 65536.
> 
> No change in the actual values.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Al, any interest in taking this patch?

- Eric
