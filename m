Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FAD490A49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 15:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbiAQOaN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 09:30:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51976 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiAQOaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:30:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2A926124D;
        Mon, 17 Jan 2022 14:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68CDC36AE3;
        Mon, 17 Jan 2022 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642429811;
        bh=3+NrhCEfm2IbaPp+AYt3M0SbHkO82YRBDt1XbhQjt1c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fpDtJ0ZVUaMDldomw2s7bFQ2rwlRCbJYkDpygraZ5nEULZHwJTT0MLEs/Qlv4odgR
         DKg5b7hVqVGc/gweceuOK506W310J+4AvB+6APYX75/MsdpU4/eEDpZkYkCkITvDPj
         1fF23iUKDleLr2zUXmgOr5sjU7BC+kZXzpcT1MSuEWyvAbjGMLkxwkMpi74xxOq2rx
         XLAIaOonLoE+7Z6/mQknjQSCOfkeBlX7yLPOhaWvaUuq70Z8U6JWOOEF27VagL2BxD
         8EuXApIhTLnTRRgPaHNQL3sl5SkMcyQWedcKOvjH1LeY2EyZYsMGmrhagx+uKiueZ1
         lZfhw8QZpFeRw==
Message-ID: <b9ad354b5282dbfce6c64287e14132ace83d91ef.camel@kernel.org>
Subject: Re: [PATCH 1/3] ceph: Uninline the data on a file opened for writing
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 17 Jan 2022 09:30:09 -0500
In-Reply-To: <2768911.1642429628@warthog.procyon.org.uk>
References: <240e60443076a84c0599ccd838bd09c97f4cc5f9.camel@kernel.org>
         <164242347319.2763588.2514920080375140879.stgit@warthog.procyon.org.uk>
         <YeVzZZLcsX5Krcjh@casper.infradead.org>
         <2768911.1642429628@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-01-17 at 14:27 +0000, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
> 
> > That would be nicer, I think. If you do that though, then patch #3
> > probably needs to come first in the series...
> 
> Seems reasonable.  Could you do that, or do you want me to have a go at it?
> 

Do you mind doing it? I can take a stab at it, but it may be a while
before I can get to it.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
