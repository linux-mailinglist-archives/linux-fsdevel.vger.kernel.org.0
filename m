Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8300103BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 03:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfEABtr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 21:49:47 -0400
Received: from ms.lwn.net ([45.79.88.28]:50968 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfEABtr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:49:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 50D50891;
        Wed,  1 May 2019 01:49:46 +0000 (UTC)
Date:   Tue, 30 Apr 2019 19:49:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH 0/4] vfs: update ->get_link() related documentation
Message-ID: <20190430194943.4a7916be@lwn.net>
In-Reply-To: <20190501013649.GO23075@ZenIV.linux.org.uk>
References: <20190411231630.50177-1-ebiggers@kernel.org>
        <20190422180346.GA22674@gmail.com>
        <20190501002517.GF48973@gmail.com>
        <20190501013649.GO23075@ZenIV.linux.org.uk>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 May 2019 02:36:49 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> Thought I'd replied; apparently not...  Anyway, the problem with those
> is that there'd been a series of patches converting vfs.txt to new
> format; I'm not sure what Jon is going to do with it, but these are
> certain to conflict.  I've no objections to the contents of changes,
> but if that stuff is getting massive reformatting the first two
> probably ought to go through Jon's tree.  I can take the last two
> at any point.
> 
> Jon, what's the status of the format conversion?

Last I saw, it seemed that you wanted changes in how things were done and
that Tobin (added to CC) had stepped back.  Tobin, are your thoughts on
the matter different?  I could try to shoehorn them in for 5.2 still, I
guess, but perhaps the best thing to do is to just take Eric's patch, and
the reformatting can work around it if need be.

Thanks,

jon
