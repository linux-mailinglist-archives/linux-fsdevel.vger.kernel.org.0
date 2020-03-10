Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8618059D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 18:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCJRzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 13:55:40 -0400
Received: from ms.lwn.net ([45.79.88.28]:44440 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCJRzk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:55:40 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B706F537;
        Tue, 10 Mar 2020 17:55:39 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:55:38 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 7/9] docs: filesystems: fuse.rst: supress a Sphinx
 warning
Message-ID: <20200310115538.12a8809d@lwn.net>
In-Reply-To: <cad541ec7d8d220d57bd5d097d60c62da64054ac.1583250595.git.mchehab+huawei@kernel.org>
References: <afbe367ccb7b9abcb9fab7bc5cb5e0686c105a53.1583250595.git.mchehab+huawei@kernel.org>
        <cad541ec7d8d220d57bd5d097d60c62da64054ac.1583250595.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue,  3 Mar 2020 16:50:37 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Get rid of this warning:
> 
>     Documentation/filesystems/fuse.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
> 
> Fixes: 8ab13bca428b ("Documentation: filesystems: convert fuse to RST")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/filesystems/fuse.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

jon
