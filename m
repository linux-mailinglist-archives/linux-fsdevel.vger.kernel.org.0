Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09489346112
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 15:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhCWOJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 10:09:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33745 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhCWOJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:09:43 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOhj0-0007bw-S4; Tue, 23 Mar 2021 14:09:38 +0000
Date:   Tue, 23 Mar 2021 15:09:38 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Theodore Tso <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: introduce a wrapper uuid_to_fsid()
Message-ID: <20210323140938.tv2ykukb7w7i66wp@wittgenstein>
References: <20210322173944.449469-1-amir73il@gmail.com>
 <20210322173944.449469-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322173944.449469-2-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:39:43PM +0200, Amir Goldstein wrote:
> Some filesystem's use a digest of their uuid for f_fsid.
> Create a simple wrapper for this open coded folding.
> 
> Filesystems that have a non null uuid but use the block device
> number for f_fsid may also consider using this helper.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Seen that as part of your other series yesterday. Looks like a good
improvement and removes a bunch of open-coding.
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
