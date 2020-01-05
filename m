Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E82130806
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 13:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgAEMsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 07:48:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46669 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgAEMsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 07:48:00 -0500
Received: from [172.58.27.182] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1io5K1-0002I0-8L; Sun, 05 Jan 2020 12:47:58 +0000
Date:   Sun, 5 Jan 2020 13:47:49 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: Re: [PATCH v8 1/3] vfs, fdtable: Add get_task_file helper
Message-ID: <20200105124747.narl7otqr3d46ljp@wittgenstein>
References: <20200103162928.5271-1-sargun@sargun.me>
 <20200103162928.5271-2-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200103162928.5271-2-sargun@sargun.me>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 03, 2020 at 08:29:26AM -0800, Sargun Dhillon wrote:
> This introduces a function which can be used to fetch a file, given an
> arbitrary task. As long as the user holds a reference (refcnt) to the
> task_struct it is safe to call, and will either return NULL on failure,
> or a pointer to the file, with a refcnt.
> 
> This patch is based on Oleg Nesterov's (cf. [1]) patch from September
> 2018.
> 
> [1]: Link: https://lore.kernel.org/r/20180915160423.GA31461@redhat.com
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Nit: the patch is titled "vfs, fdtable: Add get_task_file helper"
but the actual helper is called fget_task()
