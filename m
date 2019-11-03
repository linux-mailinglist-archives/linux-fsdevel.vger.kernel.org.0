Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3434ED410
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 18:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfKCR4y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 12:56:54 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38250 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727758AbfKCR4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 12:56:54 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA3HumMC028282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Nov 2019 12:56:49 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 23DB3420311; Sun,  3 Nov 2019 12:56:48 -0500 (EST)
Date:   Sun, 3 Nov 2019 12:56:48 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
Message-ID: <20191103175648.GA4603@mit.edu>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
> Several items in /proc/sys need not be accessible to unprivileged
> tasks. Let the system administrator change the permissions, but only
> to more restrictive modes than what the sysctl tables allow.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

Why should restruct the system administrator from changing the
permissions to one which is more lax than what the sysctl tables?

The system administrator is already very much trusted.  Why should we
take that discretion away from the system administrator?

     	  	     	       	   	  - Ted
