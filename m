Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190E238B09A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 15:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239482AbhETN5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 09:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:50468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238751AbhETN4x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 09:56:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8DB8ABCD;
        Thu, 20 May 2021 13:55:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6A0451F2C9C; Thu, 20 May 2021 15:55:27 +0200 (CEST)
Date:   Thu, 20 May 2021 15:55:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <20210520135527.GD18952@quack2.suse.cz>
References: <cover.1621473846.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621473846.git.repnop@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-05-21 12:09:45, Matthew Bobrowski wrote:
> Hey Jan/Amir/Christian,
> 
> This is the updated patch series for adding pidfd support to the
> fanotify API. It incorporates all the suggestions that had come out of
> the initial RFC patch series [0].
> 
> The main difference with this patch series is that FAN_REPORT_PIDFD
> results in an additional info record object supplied alongside the
> generic event metadata object instead of overloading metadata->pid. If
> any of the fid flavoured init flags are specified, then the pidfd info
> record object will follow any fid info record objects.
> 
> [0] https://www.spinics.net/lists/linux-fsdevel/msg193296.html

Overall the series looks fine to me - modulo the problems Christian & Amir
found. Do you have any tests for this? Preferably for LTP so that we can
extend the coverage there?

								Honza

> 
> Matthew Bobrowski (5):
>   kernel/pid.c: remove static qualifier from pidfd_create()
>   kernel/pid.c: implement checks on parameters passed to pidfd_create()
>   fanotify_user.c: minor cosmetic adjustments to fid labels
>   fanotify/fanotify_user.c: introduce a generic info record copying
>     function
>   fanotify: Add pidfd info record support to the fanotify API
> 
>  fs/notify/fanotify/fanotify_user.c | 216 +++++++++++++++++++----------
>  include/linux/fanotify.h           |   3 +
>  include/linux/pid.h                |   1 +
>  include/uapi/linux/fanotify.h      |  12 ++
>  kernel/pid.c                       |  15 +-
>  5 files changed, 170 insertions(+), 77 deletions(-)
> 
> -- 
> 2.31.1.751.gd2f1c929bd-goog
> 
> /M
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
