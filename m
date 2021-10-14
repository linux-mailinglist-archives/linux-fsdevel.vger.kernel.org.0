Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4342E3E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 23:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhJNWBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 18:01:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38712 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229829AbhJNWB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 18:01:29 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19ELx9av011867
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 17:59:10 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B48AD15C00CA; Thu, 14 Oct 2021 17:59:09 -0400 (EDT)
Date:   Thu, 14 Oct 2021 17:59:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 26/28] ext4: Send notifications on error
Message-ID: <YWioLfIxwcnemDwj@mit.edu>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-27-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-27-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 14, 2021 at 06:36:44PM -0300, Gabriel Krisman Bertazi wrote:
> Send a FS_ERROR message via fsnotify to a userspace monitoring tool
> whenever a ext4 error condition is triggered.  This follows the existing
> error conditions in ext4, so it is hooked to the ext4_error* functions.
> 
> It also follows the current dmesg reporting in the format.  The
> filesystem message is composed mostly by the string that would be
> otherwise printed in dmesg.
> 
> A new ext4 specific record format is exposed in the uapi, such that a
> monitoring tool knows what to expect when listening errors of an ext4
> filesystem.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

