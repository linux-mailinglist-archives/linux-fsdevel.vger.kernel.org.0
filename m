Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CF62C24F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 12:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbgKXLuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 06:50:07 -0500
Received: from verein.lst.de ([213.95.11.211]:54161 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgKXLuG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:50:06 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id EDB576736F; Tue, 24 Nov 2020 12:50:04 +0100 (CET)
Date:   Tue, 24 Nov 2020 12:50:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: fs{set,get}attr iops
Message-ID: <20201124115004.GB22619@lst.de>
References: <20201123141207.GC327006@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123141207.GC327006@miu.piliscsaba.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks pretty neat from a quick look, but you probably want to split
it into a patch or two adding the infrastructure and then one patch
per file system to ease review and bisection.
