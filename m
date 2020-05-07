Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5A1C9A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 21:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgEGTBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 15:01:40 -0400
Received: from nibbler.cm4all.net ([82.165.145.151]:59003 "EHLO
        nibbler.cm4all.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGTBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 15:01:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id 5E8EEC023F
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 21:01:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id DWQhMtXS3y_R for <linux-fsdevel@vger.kernel.org>;
        Thu,  7 May 2020 21:01:36 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id 33AD1C01F8
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 21:01:36 +0200 (CEST)
Received: (qmail 2452 invoked from network); 7 May 2020 22:17:53 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 7 May 2020 22:17:53 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 08C93461450; Thu,  7 May 2020 21:01:36 +0200 (CEST)
Date:   Thu, 7 May 2020 21:01:36 +0200
From:   Max Kellermann <mk@cm4all.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Max Kellermann <mk@cm4all.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/io_uring: fix O_PATH fds in openat, openat2, statx
Message-ID: <20200507190135.GA15950@rabbit.intern.cm-ag>
References: <20200507185725.15840-1-mk@cm4all.com>
 <a048108e-67e0-b261-ab56-312a98045255@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a048108e-67e0-b261-ab56-312a98045255@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/05/07 20:58, Jens Axboe <axboe@kernel.dk> wrote:
> Do you happen to have a liburing test addition for this as well?

No, I'll write one tomorrow.  GitHub PR or email preferred?

Max
