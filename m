Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26529E57E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 08:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbgJ2H5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgJ2HYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:40 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B27FC0613D3;
        Wed, 28 Oct 2020 19:44:37 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXxvX-00B2OP-P0; Thu, 29 Oct 2020 02:44:35 +0000
Date:   Thu, 29 Oct 2020 02:44:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     zc <zoucao@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs:regfs: add register easy filesystem
Message-ID: <20201029024435.GO3576660@ZenIV.linux.org.uk>
References: <1603175408-96164-1-git-send-email-zoucao@linux.alibaba.com>
 <00513aa5-1cc5-bc1c-1ca7-d5cd6e3f1ed6@linux.alibaba.com>
 <fe9f0382-da87-77ab-75ab-5a4bec0a9a21@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe9f0382-da87-77ab-75ab-5a4bec0a9a21@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:27:20PM +0800, zc wrote:
> Hi viro:
> 
>    have time for reviewing this?

Start with removing unused boilerplate.  When quite a chunk
of the codebase is simply never used, filtering _that_ out
is on the author, not reviewers.
