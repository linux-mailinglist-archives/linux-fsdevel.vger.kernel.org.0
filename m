Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F65B346126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 15:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhCWONi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 10:13:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34157 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbhCWONI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:13:08 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lOhmI-00083w-2N; Tue, 23 Mar 2021 14:13:02 +0000
Date:   Tue, 23 Mar 2021 15:13:01 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Theodore Tso <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] Better fanotify support for tmpfs
Message-ID: <20210323141301.kcmmk7522okynnbf@wittgenstein>
References: <20210322173944.449469-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322173944.449469-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 07:39:42PM +0200, Amir Goldstein wrote:
> Jan,
> 
> I needed the tmpfs patch for the userns filesystem mark POC, but it
> looks useful for its own right to be able to set filesystem mount or
> inode marks on tmpfs with FAN_REPORT_FID.

Indeed.
Seems how to generate the fs_id part based on the uuid is a bit
controversial for some fses (from the xfs thread) but this series seems
useful. Being able to place marks on tmpfs is worth it.

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
