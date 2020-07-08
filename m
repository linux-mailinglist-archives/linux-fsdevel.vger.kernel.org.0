Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7998C217FB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 08:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgGHGis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 02:38:48 -0400
Received: from verein.lst.de ([213.95.11.211]:33796 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgGHGis (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:38:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B7BE68AFE; Wed,  8 Jul 2020 08:38:45 +0200 (CEST)
Date:   Wed, 8 Jul 2020 08:38:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        open list <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/16] init: remove the bstat helper
Message-ID: <20200708063845.GA5468@lst.de>
References: <20200615125323.930983-1-hch@lst.de> <20200615125323.930983-2-hch@lst.de> <CAPhsuW6chy6uMpow3L1WvBW8xCsUYw4SbLHQQXcANqBVcqoULg@mail.gmail.com> <20200707103439.GA2812@lst.de> <CAPhsuW6CvKMPEuUEFfZhxyyU2ke9oiYOuCwkM+NM2=bo_o_MFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6CvKMPEuUEFfZhxyyU2ke9oiYOuCwkM+NM2=bo_o_MFw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 09:54:30AM -0700, Song Liu wrote:
> Would this official mm tree work?
> 
> T:      git git://github.com/hnaz/linux-mm.git
> 
> If not, I am OK with either vfs tree or a dedicated tree.

That is a constantly rebased tree, so I don't think it helps.
