Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5474C39B810
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 13:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFDLi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 07:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhFDLi3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:38:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89797611ED;
        Fri,  4 Jun 2021 11:36:41 +0000 (UTC)
Date:   Fri, 4 Jun 2021 13:36:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fscache: Select netfs stats if fscache stats are enabled
Message-ID: <20210604113639.qlgn3nvc6iqlgner@wittgenstein>
References: <162280352566.3319242.10615341893991206961.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <162280352566.3319242.10615341893991206961.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 04, 2021 at 11:45:25AM +0100, David Howells wrote:
> Unconditionally select the stats produced by the netfs lib if fscache stats
> are enabled as the former are displayed in the latter's procfile.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-cachefs@redhat.com
> ---

That's helpful, thanks
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
