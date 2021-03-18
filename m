Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCED340A64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 17:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhCRQl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 12:41:29 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:38808 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhCRQlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:41:22 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMvfy-007A1i-GX; Thu, 18 Mar 2021 16:39:10 +0000
Date:   Thu, 18 Mar 2021 16:39:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Xiaofeng Cao <cxfcosmos@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: Re: [PATCH] fs/exec: fix typos and sentence disorder
Message-ID: <YFOCLtsiqyThIkdK@zeniv-ca.linux.org.uk>
References: <20210318153145.13718-1-caoxiaofeng@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318153145.13718-1-caoxiaofeng@yulong.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 11:31:45PM +0800, Xiaofeng Cao wrote:

> -		 * the address space in [new_end, old_start) some architectures
> +		 * the address space in [new_end, old_start]. Some architectures

	[a,b] = {x: a <= x <= y}
	[a,b) = {x: a <= x < y}

Not the same thing - closed vs. open on the right end.
