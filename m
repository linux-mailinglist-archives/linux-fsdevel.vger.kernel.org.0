Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5771625D7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 12:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgBRL5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 06:57:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgBRL5r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 06:57:47 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D60C4206F4;
        Tue, 18 Feb 2020 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582027066;
        bh=e8/QKnHiqeSaq1W/QG0QQ7RE4kwsBT4aZqqunirny+A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V+6CRAv/MTMF6+T8FNIJJO571AqN7qCSNjVF6u04YbUrPgcelJDJc9b28k/X2AMMS
         i2EVBIU+WslI4xWgMm2yNV55RiIk4FH1+6wAu/+iK+Ui0lIucE9vP1arq6gFajQIgP
         kEbHUMymr8bngiB+vcvweWi/0PblVvoeTeH6hK7s=
Message-ID: <988af69f85385384738c8a656335e385a3ded827.camel@kernel.org>
Subject: Re: [PATCH 09/44] docs: filesystems: convert ceph.txt to ReST
From:   Jeff Layton <jlayton@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org
Date:   Tue, 18 Feb 2020 06:57:44 -0500
In-Reply-To: <df2f142b5ca5842e030d8209482dfd62dcbe020f.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
         <df2f142b5ca5842e030d8209482dfd62dcbe020f.1581955849.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-02-17 at 17:11 +0100, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document title;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../filesystems/{ceph.txt => ceph.rst}        | 26 +++++++++++--------
>  Documentation/filesystems/index.rst           |  1 +
>  2 files changed, 16 insertions(+), 11 deletions(-)
>  rename Documentation/filesystems/{ceph.txt => ceph.rst} (91%)
> 

Looks fine to me. Mauro, should I merge this via the ceph tree, or are
you merging them in via some other tree? In any case:

Acked-by: Jeff Layton <jlayton@kernel.org>

