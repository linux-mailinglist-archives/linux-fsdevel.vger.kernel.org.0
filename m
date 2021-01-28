Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025B6307679
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 13:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhA1MyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 07:54:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhA1MxJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 07:53:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A92D64DDD;
        Thu, 28 Jan 2021 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611838348;
        bh=dpEoeKfLT6HgV0RyHq6DTmjg9VIT96dBb+fWM5H3JtA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Mor5yOfrUuJgYUtqrtR6BOrxZbsJu791BkMxIcEUXSSuNsHf5L8uybQDY9RXTnGGB
         zegZWqB1tT/+/MuPZmZMv19LIXeqa8Qpls+yKU+3Pt7vUqTq2h4VeKPcT/8etaObqd
         Gf/nXF7WP0r5kxENIPzyOTSqRE4+jtPzmkb5Rjw5PsMITu5RVdANNu5uKB8bPJxHfS
         AUHrKiD9gZBg1MgCfVFzdg5ZuCL5SKuSd6kPIoc5Px18LUYa3EftLyRZ3vTexCzWxE
         jlFVJRgoN8u7VbawWeRsXIoYF2DAGryIZY4Fx2s4i5CfmZUze0JUvpHzSB1Hxn9T04
         wLF6iqKu3Llwg==
Message-ID: <2301cde67ae7aa54d860fc3962aeb8ed85744c75.camel@kernel.org>
Subject: Re: [PATCH 0/6] ceph: convert to new netfs read helpers
From:   Jeff Layton <jlayton@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Ceph Development <ceph-devel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-cachefs@redhat.com
Date:   Thu, 28 Jan 2021 07:52:27 -0500
In-Reply-To: <CAOi1vP-3Ma4LdCcu6sPpwVbmrto5HnOAsJ6r9_973hYY3ODBUQ@mail.gmail.com>
References: <20210126134103.240031-1-jlayton@kernel.org>
         <CAOi1vP-3Ma4LdCcu6sPpwVbmrto5HnOAsJ6r9_973hYY3ODBUQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-01-27 at 23:50 +0100, Ilya Dryomov wrote:
> On Tue, Jan 26, 2021 at 2:41 PM Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > This patchset converts ceph to use the new netfs readpage, write_begin,
> > and readahead helpers to handle buffered reads. This is a substantial
> > reduction in code in ceph, but shouldn't really affect functionality in
> > any way.
> > 
> > Ilya, if you don't have any objections, I'll plan to let David pull this
> > series into his tree to be merged with the netfs API patches themselves.
> 
> Sure, that works for me.
> 
> I would have expected that the new netfs infrastructure is pushed
> to a public branch that individual filesystems could peruse, but since
> David's set already includes patches for AFS and NFS, let's tag along.
> 
> Thanks,
> 
>                 Ilya

David has a fscache-netfs-lib branch that has all of the infrastructure
changes. See:

    https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib

-- 
Jeff Layton <jlayton@kernel.org>

