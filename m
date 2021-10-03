Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE741FF7C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 05:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhJCDt1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Oct 2021 23:49:27 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:42012 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhJCDt0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Oct 2021 23:49:26 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWsTQ-009XeT-HF; Sun, 03 Oct 2021 03:47:36 +0000
Date:   Sun, 3 Oct 2021 03:47:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/elf: Fix kernel pointer leak
Message-ID: <YVkn2GseBWtOowHB@zeniv-ca.linux.org.uk>
References: <20210929131703.1163417-1-qtxuning1999@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929131703.1163417-1-qtxuning1999@sjtu.edu.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 09:17:02PM +0800, Guo Zhi wrote:
> Pointers should be printed with %p rather than %px
> which printed kernel pointer directly.
> Change %px to %p to print the secured pointer.

Huh?  What makes it a kernel pointer?  It's a userland address...
