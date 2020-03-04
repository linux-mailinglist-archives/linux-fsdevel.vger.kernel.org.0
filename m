Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B696179A91
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 22:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbgCDVBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 16:01:12 -0500
Received: from ms.lwn.net ([45.79.88.28]:47252 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgCDVBM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:01:12 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8AFF97F5;
        Wed,  4 Mar 2020 21:01:11 +0000 (UTC)
Date:   Wed, 4 Mar 2020 14:01:10 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
Message-ID: <20200304140110.1951004f@lwn.net>
In-Reply-To: <alpine.DEB.2.21.2003042145340.2698@felia>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
        <20200304131035.731a3947@lwn.net>
        <alpine.DEB.2.21.2003042145340.2698@felia>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 4 Mar 2020 21:50:39 +0100 (CET)
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> > Thanks for fixing these, but ... what tree did you generate the patch
> > against?  I doesn't come close to applying to docs-next.
> >  
> 
> My patch was based on next-20200303, probably too much noise on 
> MAINTAINERS, such that it does not apply cleanly on docs-next.
> If you want, I can send a patch that fits to docs-next. Anyway, merging 
> will be similarly difficult later :(

Merge conflicts in MAINTAINERS are almost always trivial to resolve -
Stephen won't mind :)

Thanks,

jon
