Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C8ADB17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfIIOV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 10:21:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58516 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfIIOV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:21:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4606B28BB4D
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unicode: make array 'token' static const, makes object smaller
Organization: Collabora
References: <20190906135807.23152-1-colin.king@canonical.com>
Date:   Mon, 09 Sep 2019 10:21:53 -0400
In-Reply-To: <20190906135807.23152-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 6 Sep 2019 14:58:07 +0100")
Message-ID: <855zm1h7ni.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Colin King <colin.king@canonical.com> writes:

> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the array 'token' on the stack but instead make it
> static const. Makes the object code smaller by 234 bytes.
>
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    5371	    272	      0	   5643	   160b	fs/unicode/utf8-core.o
>
> After:
>    text	   data	    bss	    dec	    hex	filename
>    5041	    368	      0	   5409	   1521	fs/unicode/utf8-core.o
>
> (gcc version 9.2.1, amd64)
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, I will get this queued up.

-- 
Gabriel Krisman Bertazi
