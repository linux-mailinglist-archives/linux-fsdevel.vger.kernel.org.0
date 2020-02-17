Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774D9161BAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 20:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgBQTeX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 14:34:23 -0500
Received: from ms.lwn.net ([45.79.88.28]:49104 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbgBQTeX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:34:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 791D3316;
        Mon, 17 Feb 2020 19:34:20 +0000 (UTC)
Date:   Mon, 17 Feb 2020 12:34:14 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Sterba <dsterba@suse.cz>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/44] docs: filesystems: convert btrfs.txt to ReST
Message-ID: <20200217123414.00942903@lwn.net>
In-Reply-To: <20200217185011.GI2902@twin.jikos.cz>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
        <1ef76da4ac24a9a6f6187723554733c702ea19ae.1581955849.git.mchehab+huawei@kernel.org>
        <20200217185011.GI2902@twin.jikos.cz>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 17 Feb 2020 19:50:12 +0100
David Sterba <dsterba@suse.cz> wrote:

> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Thanks. I can take the patch through btrfs tree, unless Jon wants all
> doc patches go through his tree.
> 
I'm generally happy either way.  With this particular set, though,
splitting them across trees seems likely to create a lot of merge
conflicts on the index.rst file, so it might be better to keep them all
together.

Thanks,

jon
