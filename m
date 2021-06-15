Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604233A7D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 13:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhFOLgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 07:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhFOLgP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:36:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC54461107;
        Tue, 15 Jun 2021 11:34:08 +0000 (UTC)
Date:   Tue, 15 Jun 2021 13:34:05 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/5] kernel/pid.c: remove static qualifier from
 pidfd_create()
Message-ID: <20210615113405.ytf2u23qmzaoq4yl@wittgenstein>
References: <cover.1623282854.git.repnop@google.com>
 <db15a492d4e1cd8aaecfa6802d0bb289d1b539e3.1623282854.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db15a492d4e1cd8aaecfa6802d0bb289d1b539e3.1623282854.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:20:06AM +1000, Matthew Bobrowski wrote:
> With the idea of returning pidfds from the fanotify API, we need to
> expose a mechanism for creating pidfds. We drop the static qualifier
> from pidfd_create() and add its declaration to linux/pid.h so that the
> pidfd_create() helper can be called from other kernel subsystems
> i.e. fanotify.
> 
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
> ---

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
