Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A0D2D3878
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 02:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgLIByQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 20:54:16 -0500
Received: from namei.org ([65.99.196.166]:59052 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgLIByO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:54:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id CBD5ADBF;
        Wed,  9 Dec 2020 01:53:30 +0000 (UTC)
Date:   Tue, 8 Dec 2020 17:53:30 -0800 (PST)
From:   James Morris <jmorris@namei.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into
 vfs_setxattr()
In-Reply-To: <20201207163255.564116-2-mszeredi@redhat.com>
Message-ID: <f9866764-15b-e795-60aa-b484916f66b4@namei.org>
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-2-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 7 Dec 2020, Miklos Szeredi wrote:

> cap_convert_nscap() does permission checking as well as conversion of the
> xattr value conditionally based on fs's user-ns.
> 
> This is needed by overlayfs and probably other layered fs (ecryptfs) and is
> what vfs_foo() is supposed to do anyway.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

