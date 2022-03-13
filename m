Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526FC4D7223
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 02:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiCMBuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 20:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiCMBuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 20:50:11 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE48F1E96;
        Sat, 12 Mar 2022 17:49:05 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTDM0-00AUhg-3u; Sun, 13 Mar 2022 01:49:04 +0000
Date:   Sun, 13 Mar 2022 01:49:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Max Kellermann <max.kellermann@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] include/pipe_fs_i.h: add missing #includes
Message-ID: <Yi1NkNkL5N1m4yU5@zeniv-ca.linux.org.uk>
References: <20220225185431.2617232-1-max.kellermann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225185431.2617232-1-max.kellermann@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 07:54:28PM +0100, Max Kellermann wrote:

> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index c00c618ef290..0e36a58adf0e 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -2,6 +2,9 @@
>  #ifndef _LINUX_PIPE_FS_I_H
>  #define _LINUX_PIPE_FS_I_H
>  
> +#include <linux/mutex.h>
> +#include <linux/wait.h>

TBH, I'd rather avoid breeding chain includes; sure, mutex.h and wait.h
are extremely common anyway.  Oh, well....
