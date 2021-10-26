Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0D243AAE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 06:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhJZEDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 00:03:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46725 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229487AbhJZEDI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:03:08 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19Q40VAu000440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Oct 2021 00:00:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 573C215C3F84; Tue, 26 Oct 2021 00:00:31 -0400 (EDT)
Date:   Tue, 26 Oct 2021 00:00:31 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, djwong@kernel.org,
        david@fromorbit.com, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v9 29/31] ext4: Send notifications on error
Message-ID: <YXd9X9BSjwzuciAZ@mit.edu>
References: <20211025192746.66445-1-krisman@collabora.com>
 <20211025192746.66445-30-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025192746.66445-30-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 04:27:44PM -0300, Gabriel Krisman Bertazi wrote:
> Send a FS_ERROR message via fsnotify to a userspace monitoring tool
> whenever a ext4 error condition is triggered.  This follows the existing
> error conditions in ext4, so it is hooked to the ext4_error* functions.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Acked-by: Theodore Ts'o <tytso@mit.edu>

Thanks!

					- Ted
