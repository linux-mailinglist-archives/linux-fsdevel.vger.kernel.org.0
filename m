Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123CD255CF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgH1OrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 10:47:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47198 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726322AbgH1OrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:47:18 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07SEkuEP017122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 10:46:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 861A4420128; Fri, 28 Aug 2020 10:46:56 -0400 (EDT)
Date:   Fri, 28 Aug 2020 10:46:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>, Greg Kurz <groug@kaod.org>,
        linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged
 stacking?)
Message-ID: <20200828144656.GF7180@mit.edu>
References: <20200824222924.GF199705@mit.edu>
 <20200827144452.GA1236603@ZenIV.linux.org.uk>
 <20200827162935.GC2837@work-vm>
 <11755866.l6z0jNX47O@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11755866.l6z0jNX47O@silver>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 11:11:15AM +0200, Christian Schoenebeck wrote:
> 
> Built-in path resolution would be nice, but it won't be a show stopper for 
> such common utils if not. For instance on Solaris there is:
> 
> runat <filename> <cmd> ...
> 
> which works something like fchdir(); execv(); you loose some flexibility, but 
> in practice still OK.

And we know from the Solaris experience that it was used *much* more
by malware authors (since most Unix security scanners didn't know
about forks) than any legitmate users.

Which is another way of saying, it's a bad idea --- unless you are a
malware author.

      	 	     		       - Ted
