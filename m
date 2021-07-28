Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889CF3D8EB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 15:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhG1NOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 09:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233315AbhG1NOr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:14:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A073F60FED;
        Wed, 28 Jul 2021 13:14:45 +0000 (UTC)
Date:   Wed, 28 Jul 2021 15:14:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [vfs PATCH 0/2] Fix gfs2 setattr bug
Message-ID: <20210728131443.u3zdz22ba2avx4j6@wittgenstein>
References: <20210728124734.227375-1-rpeterso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210728124734.227375-1-rpeterso@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 07:47:32AM -0500, Bob Peterson wrote:
> Hi Al,
> 
> Here is a set of two patches from Andreas Gruenbacher to fix a problem
> that causes xfstests generic/079 to fail on gfs2. The first patch moves a
> chunk of code from notify_change to its own function, may_setattr, so gfs2
> can use it. The second patch makes gfs2 use it.

lgtm,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
