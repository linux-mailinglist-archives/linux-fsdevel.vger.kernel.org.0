Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626D210A35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfEAPk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 11:40:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfEAPk7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 11:40:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 005FB8666E;
        Wed,  1 May 2019 15:40:59 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ED56629BF;
        Wed,  1 May 2019 15:40:58 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Shenghui Wang <shhuiw@foxmail.com>, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] io_uring: use cpu_online() to check p->sq_thread_cpu instead of cpu_possible()
References: <20190501072430.6674-1-shhuiw@foxmail.com>
        <x49wojaxuaa.fsf@segfault.boston.devel.redhat.com>
        <cd55b1e4-9395-a8b7-707e-ceed9d6c0c15@kernel.dk>
        <x49o94mxn1w.fsf@segfault.boston.devel.redhat.com>
        <bcf4aa58-ec09-3d73-89f8-fdfdc3ea2896@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 01 May 2019 11:40:57 -0400
In-Reply-To: <bcf4aa58-ec09-3d73-89f8-fdfdc3ea2896@kernel.dk> (Jens Axboe's
        message of "Wed, 1 May 2019 08:39:05 -0600")
Message-ID: <x49tvee89o6.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 01 May 2019 15:40:59 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> Agree, I've cleaned it up, it was a bit of a mess.

LGTM, thanks!

-Jeff
