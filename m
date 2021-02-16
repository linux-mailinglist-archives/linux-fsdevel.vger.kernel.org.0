Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B969A31C83A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 10:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBPJmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 04:42:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44349 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhBPJms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:42:48 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lBwrn-0007fR-VI; Tue, 16 Feb 2021 09:42:00 +0000
Date:   Tue, 16 Feb 2021 10:41:59 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "David P . Quigley" <dpquigl@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH -next] fs: libfs: fix kernel-doc for mnt_userns
Message-ID: <20210216094159.b4hmjsmkvvrjhdcg@wittgenstein>
References: <20210216042929.8931-1-rdunlap@infradead.org>
 <20210216042929.8931-2-rdunlap@infradead.org>
 <20210216084825.GA23845@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210216084825.GA23845@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 16, 2021 at 09:48:25AM +0100, Christoph Hellwig wrote:
> On Mon, Feb 15, 2021 at 08:29:27PM -0800, Randy Dunlap wrote:
> > Fix kernel-doc warning in libfs.c.
> > 
> > ../fs/libfs.c:498: warning: Function parameter or member 'mnt_userns' not described in 'simple_setattr'
> 
> Shouldn't the subject say simple_setattr instead of mnt_userns?
> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Just an fyi, Lukas sent a series for this 1 or 2 weeks ago
https://lore.kernel.org/lkml/20210204180059.28360-1-lukas.bulwahn@gmail.com
Hadn't yet replied to that one.

Christian
