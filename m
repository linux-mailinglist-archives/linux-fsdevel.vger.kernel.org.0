Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09AB41D634
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349344AbhI3JYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 05:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:32776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349293AbhI3JYe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:24:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27B0661278;
        Thu, 30 Sep 2021 09:22:50 +0000 (UTC)
Date:   Thu, 30 Sep 2021 11:22:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] procfs: Do not list TID 0 in /proc/<pid>/task
Message-ID: <20210930092248.paseltc6wywmwyjr@wittgenstein>
References: <8735pn5dx7.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8735pn5dx7.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:23:32PM +0200, Florian Weimer wrote:
> If a task exits concurrently, task_pid_nr_ns may return 0.
> 
> Signed-off-by: Florian Weimer <fweimer@redhat.com>
> ---

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
