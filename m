Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACC9E3607
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409544AbfJXOzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 10:55:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54687 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409522AbfJXOzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:55:18 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9OEt4lp029979
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 10:55:05 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 769AE420456; Thu, 24 Oct 2019 10:55:04 -0400 (EDT)
Date:   Thu, 24 Oct 2019 10:55:04 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: File system for scratch space (in HPC cluster)
Message-ID: <20191024145504.GD1124@mit.edu>
References: <e143071a-b1dc-56a4-a82e-865bae4c60c1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e143071a-b1dc-56a4-a82e-865bae4c60c1@molgen.mpg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 12:43:40PM +0200, Paul Menzel wrote:
> 
> In our cluster, we offer scratch space for temporary files. As
> these files are temporary, we do not need any safety
> requirements – especially not those when the system crashes or
> shuts down. So no `sync` is for example needed.
> 
> Are there file systems catering to this need? I couldn’t find
> any? Maybe I missed some options for existing file systems.

You could use ext4 in nojournal mode.  If you want to make sure that
fsync() doesn't force a cache flush, you can mount with the nobarrier
mount option.

					- Ted
